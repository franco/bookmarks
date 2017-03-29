require 'rails_helper'

RSpec.describe BookmarkSiteSynchronizer do

  let :base_url { 'http://test.com' }
  let :bookmark { Bookmark.new name: 'test', url: 'http://test.com/xyz' }
  let :bookmark_site_synchronizer { BookmarkSiteSynchronizer.new(bookmark) }

  describe "#save" do
    context "with no matching Site" do
      it "creates a matching Site" do
        expect(Site.find_by url: base_url).to be_nil
        BookmarkSiteSynchronizer.new(bookmark).save
        expect(Site.find_by url: base_url).to be_present 
      end
    end

    context "with matching Site" do
      it "assignes the matching Site" do
        site = Site.create!(url: base_url)
        BookmarkSiteSynchronizer.new(bookmark).save
        expect(bookmark.site).to eq(site)
      end
    end
  end

  describe "#update" do
    before :each do
      bookmark_site_synchronizer.save
    end
    it "does not touch the Site if url has not changed" do
      site = spy("site")
      allow(bookmark).to receive(:site) { site }
      bookmark_params = { name: 'changed' }
      bookmark_site_synchronizer.update bookmark_params
      expect(site).to_not have_received(:update)
    end

    it "updates the matching Site if only this bookmark is under the matching Site" do
      site = bookmark.site
      allow(bookmark.site).to receive(:single_bookmark?) { true }
      bookmark_params = { url: 'http://www.wikipedia.com/xyz' }
      bookmark_site_synchronizer.update bookmark_params
      expect(bookmark.url).to eq(bookmark_params[:url])
      expect(site).to eq(bookmark.site)
      expect(bookmark.site.url).to eq(BaseUrl.new(bookmark.url).trim)
    end

    it "creates a new Site if the updated url changes in the base url part and the matching Site has other bookmarks associated" do

      site = bookmark.site
      allow(bookmark.site).to receive(:single_bookmark?) { false }
      bookmark_params = { url: 'http://www.wikipedia.com/xyz' }
      bookmark_site_synchronizer.update bookmark_params
      expect(bookmark.url).to eq(bookmark_params[:url])
      expect(site).not_to eq(bookmark.site)
      expect(bookmark.site.url).to eq(BaseUrl.new(bookmark.url).trim)
    end

    it "does not touch the Site if the url has changed but it has no affect on the base url" do
      site = bookmark.site
      allow(bookmark.site).to receive(:single_bookmark?) { false }
      bookmark_params = { url: base_url + '/changed_path' }
      bookmark_site_synchronizer.update bookmark_params
      expect(bookmark.url).to eq(bookmark_params[:url])
      expect(site).to eq(bookmark.site)
    end

  end

  describe "#delete" do
    let :site { spy('site') }
    before :each do
      allow(bookmark).to receive(:site) { site }
      bookmark_site_synchronizer.save
    end

    it "destroys the bookmark" do
      bookmark_site_synchronizer.destroy
      expect(bookmark).to be_destroyed
    end

    it "destroys orphaned sites" do
      bookmark_site_synchronizer.destroy
      expect(site).to have_received(:destroy_if_orphaned)
    end

    it "returns the destoryed bookmark" do
      returned_bookmark = bookmark_site_synchronizer.destroy
      expect(returned_bookmark).to eq(bookmark)
      expect(returned_bookmark).to be_frozen 
    end
  end
end
