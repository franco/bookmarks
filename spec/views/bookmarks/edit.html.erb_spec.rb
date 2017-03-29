require 'rails_helper'

RSpec.describe "bookmarks/edit", type: :view do
  before(:each) do
    @bookmark = assign(:bookmark, Bookmark.create!(
      :name => "Google",
      :url => "http://www.google.com/xyz",
      :short_url => "http://goo.gl/xyz",
      :site => Site.new(url: "http://www.google.com")
    ))
  end

  it "renders the edit bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmark_path(@bookmark), "post" do

      assert_select "input#bookmark_name[name=?]", "bookmark[name]"

      assert_select "input#bookmark_url[name=?]", "bookmark[url]"

      assert_select "input#bookmark_short_url[name=?]", "bookmark[short_url]"

    end
  end
end
