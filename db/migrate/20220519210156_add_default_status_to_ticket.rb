class AddDefaultStatusToTicket < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :status, :string, :default => "Sended"
  end
end
