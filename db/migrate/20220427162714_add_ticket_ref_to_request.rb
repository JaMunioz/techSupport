class AddTicketRefToRequest < ActiveRecord::Migration[7.0]
  def change
    add_reference :requests, :ticket, null: false, foreign_key: true
  end
end
