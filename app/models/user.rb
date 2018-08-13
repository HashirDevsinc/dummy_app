class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :comment_records, class_name: "Record", foreign_key: "reporter_id"
	has_many :user_reports, through: :comment_records, source: :comment  

  has_many :posts
  has_many :comments
  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true
end
