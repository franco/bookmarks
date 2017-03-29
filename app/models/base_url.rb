# Public: BaseUrl parses a url and trims it to its base url.
class BaseUrl

  def initialize url
    @original_url = url
  end

  # Public: Trim a Url to its base.
  #
  # Returns the base Url.
  def trim
    return nil if @original_url.nil?

    # Using Addressable::URI#join with '/' is a trick to get back
    # only the base url with an appended '/'
    base_url = Addressable::URI.parse(@original_url).join('/').to_s
    if base_url.size > 1
      base_url.gsub /\/$/, ""
    else
      @original_url
    end
  end
end
