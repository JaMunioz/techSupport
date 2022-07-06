class ExecutiveReport < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validates :calification, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
end
