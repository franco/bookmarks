require 'rails_helper'

RSpec.describe Site, type: :model do

  describe "url" do
    it "considers always only the base part for every AR method" do
      base_url = "http://test.com"
      site = Site.new url: "http://test.com/xyz.html"
      expect(site.url).to eq(base_url)
    end
  end
end
