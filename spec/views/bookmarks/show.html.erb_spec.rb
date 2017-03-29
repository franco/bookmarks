require 'rails_helper'

RSpec.describe "bookmarks/show", type: :view do
  before(:each) do
    @bookmark = assign(:bookmark, Bookmark.create!(
      :name => "Google",
      :url => "http://www.google.com/xyz",
      :short_url => "http://goo.gl/xyz",
      :site => Site.new(url: "http://www.google.com")
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Google/)
    expect(rendered).to match(/http:\/\/www\.google\.com\/xyz/)
    expect(rendered).to match(/http:\/\/goo\.gl\/xyz/)
    expect(rendered).to match(/http:\/\/www\.google\.com/)
  end
end
