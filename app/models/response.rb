class Response < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validates :response, presence: true
end
