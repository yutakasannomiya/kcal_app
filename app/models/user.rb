class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   with_options presence: true do
      validates :name
      validates :birthday
      validates :height
      validates :weight
    end

  
  belongs_to :sex, class_name: 'Sex'

  has_many :checks, dependent: :destroy
  has_many :articles, through: :checks

  # belongs_to :sex, polymorphic: true
end
