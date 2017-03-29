class AddTagsToBookmarks < ActiveRecord::Migration[5.0]
  def change
    change_table :bookmarks do |t|
      t.text  :tags, array: true, default: []
      t.index :tags, using: 'gin'
    end
  end
end
