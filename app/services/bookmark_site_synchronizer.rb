class BookmarkSiteSynchronizer

  attr_accessor :bookmark

  def initialize bookmark
    self.bookmark = bookmark
  end

  def save
    bookmark.site = Site.find_or_initialize_by url: bookmark.url
    bookmark.save
  end

  def update bookmark_params
    base_url = BaseUrl.new(bookmark_params[:url]).trim
    if bookmark_params.has_key?(:url) && bookmark.site.url != base_url
      bookmark.transaction do
        if bookmark.site.single_bookmark?
          bookmark.site.update url: base_url
        else
          bookmark.site = Site.new url: base_url
        end
        bookmark.update bookmark_params
      end
    else
      bookmark.update bookmark_params
    end
  end

  def destroy
    Bookmark.transaction do
      bookmark.destroy
      bookmark.site.destroy_if_orphaned
      bookmark
    end
  end

  private
    def site
      bookmark.site
    end
end
