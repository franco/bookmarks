# A Site groups bookmarks togehter by their base URL.
# Therefore the AR class will always "sanitize" non-base
# URLs used in interacting with this class by trimming the
# URL to its base URL. This is achieved by using a Serializer.
class Site < ApplicationRecord

  class UrlSerializer
    def dump value
      BaseUrl.new(value).trim
    end
    def load value
      value
    end
  end
  private_constant :UrlSerializer

  has_many :bookmarks, dependent: :destroy

  serialize :url, UrlSerializer.new 
  validates :url, presence: true, uniqueness: true, http_url: true

  def has_bookmarks?
    bookmarks_count > 0
  end

  def single_bookmark?
    bookmarks_count == 1
  end

  # Deletes the Site if there are no more bookmarks associated
  def destroy_if_orphaned
    destroy unless has_bookmarks?
  end

end
