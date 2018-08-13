class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, :as => :imageable

	accepts_nested_attributes_for :images, :allow_destroy => true

  validates :title, presence: true
  validates :body, presence: true
  acts_as_paranoid
end
