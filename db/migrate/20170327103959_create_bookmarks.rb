class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.text :url
      t.string :short_url
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end
