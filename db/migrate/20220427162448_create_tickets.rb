class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.datetime :incident_creation_date
      t.datetime :date_incident
      t.datetime :date_ticket_resolution
      t.string :title
      t.string :description
      t.string :priority
      t.string :status
      t.string :tags
      t.string :documents
      t.datetime :ticket_deadline
      t.boolean :assisted
      t.boolean :reopen
      t.attachment :flyer

      t.timestamps
    end
  end
end
