module BookmarksHelper

  def textify_tags value
    if value.is_a? Array
      value.join ', '
    else
      value
    end
  end
end
