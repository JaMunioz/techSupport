class Ticket < ApplicationRecord
  has_many :requests, dependent: :delete_all
  has_many :responses, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :executive_reports, dependent: :delete_all
  has_many :executive_assigneds, dependent: :delete_all
  has_one_attached :flyer
  validates :title, presence: true
  validates :description, presence: true
  validates :date_incident, presence: true
end
