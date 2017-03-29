require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'site validation' do
    it 'is invalid without a site' do
      b = Bookmark.new(name: 'Wikipedia', url: 'https://www.wikipedia.com/articlex')
      expect(b).to be_invalid
    end
    it 'is invalid with a non-matching base url' do
      b = Bookmark.new(
        name: 'Wikipedia', 
        url: 'https://www.wikipedia.com/articlex',
        site: Site.new(url: 'https://test.com')
      )
      expect(b).to be_invalid
    end
    it 'is valid with a matching base url' do
      b = Bookmark.new(
        name: 'Wikipedia', 
        url: 'https://www.wikipedia.com/articlex',
        site: Site.new(url: 'https://www.wikipedia.com')
      )
      expect(b).to be_valid
    end

  end
  describe '.search' do
    it 'looks up a term in name, url, and short_url' do
      Bookmark.create!(
        name: 'Cool site', 
        url: 'https://www.wikipedia.com/articlex',
        short_url: 'https://goo.gl/xyz',
        site: Site.new(url: 'https://www.wikipedia.com')
      )
      expect(Bookmark.search('site').count).to eq(1)
      expect(Bookmark.search('article').count).to eq(1)
      expect(Bookmark.search('goo').count).to eq(1)
    end
  end
end
