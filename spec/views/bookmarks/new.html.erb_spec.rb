require 'rails_helper'

RSpec.describe "bookmarks/new", type: :view do
  before(:each) do
    assign(:bookmark, Bookmark.new(
      :name => "Google",
      :url => "http://www.google.com/xyz",
      :short_url => "http://goo.gl/xyz",
      :site => Site.new(url: "http://www.google.com")
    ))
  end

  it "renders new bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmarks_path, "post" do

      assert_select "input#bookmark_name[name=?]", "bookmark[name]"

      assert_select "input#bookmark_url[name=?]", "bookmark[url]"

      assert_select "input#bookmark_short_url[name=?]", "bookmark[short_url]"
    end
  end
end
