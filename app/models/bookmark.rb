class Bookmark < ApplicationRecord
  belongs_to :site

  validates :name, presence: true
  validates :url,  presence: true, uniqueness: true
end
