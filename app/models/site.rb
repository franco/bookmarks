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

  serialize :url, UrlSerializer.new 
  validates :url, presence: true, uniqueness: true
end
