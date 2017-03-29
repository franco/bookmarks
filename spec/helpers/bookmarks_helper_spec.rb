require 'rails_helper'

RSpec.describe BookmarksHelper, type: :helper do
  describe "#textify_tags" do
    it "returns the unchanged string in case of a string" do
      expect(helper.textify_tags "tag1, tag2" ).to eq("tag1, tag2")
    end
    it "returns an array as comma-separated string" do
      expect(helper.textify_tags ["tag1, tag2"] ).to eq("tag1, tag2")
    end
  end
end
