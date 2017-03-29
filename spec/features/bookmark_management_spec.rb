require 'rails_helper'

RSpec.feature "Bookmark management", type: :feature do
  scenario "User creates a new bookmark" do
    visit "/bookmarks/new"
    fill_in "Name", with: "Who is hiring March 2017"
    fill_in "URL", with: "https://news.ycombinator.com/item?id=13764728"
    click_button "Create Bookmark"
    expect(page).to have_text "Bookmark was successfully created"
  end

  scenario "User creates a new bookmark with invalid url" do
    visit "/bookmarks/new"
    click_button "Create Bookmark"
    expect(page).to have_text "Name can't be blank"
    expect(page).to have_text "URL can't be blank"

    fill_in "Name", with: "Who is hiring March 2017"
    fill_in "URL", with: "htttps://news.ycombinator.com/item?id=13764728"
    click_button "Create Bookmark"
    expect(page).to have_text "URL is not a valid http(s) url"

    fill_in "URL", with: "https://news.ycombinator.com/item?id=13764728"
    fill_in "Short URL", with: "htt://goo.gl/xyz"
    click_button "Create Bookmark"
    expect(page).to have_text "Short URL is not a valid http(s) url"
  end

end
