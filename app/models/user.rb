class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 validates :username, presence: true, uniqueness: true

 has_many :posts
 has_many :likes
 has_many :comments
 has_one_attached :avatar
 before_create :randomize_id

has_many :follower_relationships, foreign_key: :followable_id, class_name: 'FollowerRelationship'
has_many :followers, through: :follower_relationships, source: :follower

has_many :followed_relationships, foreign_key: :follower_id, class_name: 'FollowerRelationship'
has_many :following, through: :followed_relationships, source: :followable

    def follow_requests
    follower_relationships.where(approved: false)
    end

    def unfollow(user)
    follower_relationships.where(followable_id: user.id).destroy_all
    end

    def self.ransackable_attributes(auth_object = nil)
    ["bio", "created_at", "email", "id", "remember_created_at", "role", "updated_at", "username"]
    end

    # public セクションの下にメソッドを配置する
    public

    def following?(user)
     follower_relationships.where(followable_id: user.id, approved: true).exists?
    end

    def sent_follow_request_to?(user)
     follower_relationships.where(followable_id: user.id, approved: false).exists?
    end

    private

    def randomize_id
    begin
    self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
    end


          enum role: [:user, :admin]
          after_initialize :set_default_role, :if => :new_record?
          def set_default_role
          self.role ||= :user
          end


end