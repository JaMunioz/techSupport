class AddTicketRefToResponse < ActiveRecord::Migration[7.0]
  def change
    add_reference :responses, :ticket, null: false, foreign_key: true
  end
end
