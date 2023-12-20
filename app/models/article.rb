class Article < ApplicationRecord
  has_many :checks, dependent: :destroy
  has_many :users, through: :checks
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :title, length: { maximum: 20}
    validates :content
    validates :about_time
    validates :user_id
  end
end
