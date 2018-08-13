class Record < ApplicationRecord
	belongs_to :comment, class_name: "Comment"
	belongs_to :reporter, class_name: "User"

	validates :comment_id, presence: true, uniqueness: { scope: :reporter_id }
	validates :reporter_id, presence: true
end
