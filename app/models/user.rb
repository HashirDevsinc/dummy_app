class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :comment_records, class_name: "Record", foreign_key: "reporter_id"
	has_many :user_reports, through: :comment_records, source: :comment  

  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_one :image, :as => :imageable

  # Friendship Associations
  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

  accepts_nested_attributes_for :image, :allow_destroy => true

  # acts_as_paranoid

  def soft_delete  
    update_attribute(:deleted_at, Time.current)
    @posts = Post.where(user_id: id)
    @posts.each do |post|
      post.destroy
    end 
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at
    # update_attribute(:deleted_at, nil)    
  end

  # to call all your friends
  def friends
    active_friends | received_friends
  end
# to call your pending sent or received
  def pending
    pending_friends | requested_friendships
  end
end
