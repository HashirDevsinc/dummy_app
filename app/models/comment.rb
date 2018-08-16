class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :reporter_records, class_name: "Record", foreign_key: "comment_id"
  has_many :reporters, through: :reporter_records, source: :reporter

  validates :content, presence: true

  scope :reported_comments, -> { joins(:reporters) }

  acts_as_paranoid
end
