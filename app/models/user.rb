class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :requests, dependent: :delete_all
  has_many :responses, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :executive_reports, dependent: :delete_all
  has_many :executive_assigneds, dependent: :delete_all
  validates :email, presence: true, email:true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence:true
  validates :telephone, uniqueness: true
end
