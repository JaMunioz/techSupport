class AddTicketRefToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :ticket, null: false, foreign_key: true
  end
end
