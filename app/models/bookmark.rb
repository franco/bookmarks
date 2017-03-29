class Bookmark < ApplicationRecord
  belongs_to :site, counter_cache: true

  validates :name, presence: true
  validates :url,  presence: true, uniqueness: true, http_url: true
  validates :short_url, http_url: true
  validate :site_has_matching_base_url

  private
    def site_has_matching_base_url
      if url_changed? && BaseUrl.new(url).trim != site.try(:url)
        errors.add :site, 'base URL does not match URL'
      end
    end
end
