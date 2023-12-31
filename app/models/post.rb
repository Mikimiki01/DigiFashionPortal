class Post < ApplicationRecord
  acts_as_punchable
  
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :keywords, presence: true, length: { minimum: 5, maximum: 100 }
  
  # Associations
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many_attached :images
  has_many :comments
  has_many :likes

  before_create :randomize_id

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while Post.where(id: self.id).exists?
  end
  
  def delete_related_data
    comments.destroy_all
    likes.destroy_all
  end
  
end