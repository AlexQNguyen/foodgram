class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :description, :name, presence: true, length: {minimum:3}
  validates :user_id, presence: true
end
