require 'rails_helper'

RSpec.describe Site do
  describe "#trip" do

    test_cases = {
      'http://www.test.com/xyz.html' => 'http://www.test.com',
      'https://www.test.com'         => 'https://www.test.com',
      'http://user:pwd@www.test.com' => 'http://user:pwd@www.test.com',
      'something other than a URL'   => 'something other than a URL'
    }

    test_cases.each do |full_url, base_url| 
      it "trims the url '#{full_url}' correctly" do
        base_url = BaseUrl.new(full_url).trim
        expect(base_url).to eq(base_url)
      end
    end

    it "handles nil values" do
      expect(BaseUrl.new(nil).trim).to be_nil
    end

  end
end
