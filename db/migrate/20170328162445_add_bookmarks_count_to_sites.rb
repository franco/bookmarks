class AddBookmarksCountToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :bookmarks_count, :integer, default: 0
  end
end
