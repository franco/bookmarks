require 'rails_helper'

RSpec.describe "bookmarks/index", type: :view do
  before(:each) do
    assign(:bookmarks, [
      Bookmark.create!(
        :name => "Google",
        :url => "http://www.google.com/xyz",
        :short_url => "http://goo.gl/xyz",
        :site => Site.new(url: "http://www.google.com")
      ),
      Bookmark.create!(
        :name => "Google",
        :url => "http://www.wikipedia.com/xyz",
        :short_url => "http://goo.gl/wik",
        :site => Site.new(url: "http://www.wikipedia.com")
      )
    ])
  end

  it "renders a list of bookmarks" do
    render
    assert_select "article h2", :text => "Google".to_s, :count => 2
  end
end
