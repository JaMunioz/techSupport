class CreateExecutiveAssigneds < ActiveRecord::Migration[7.0]
  def change
    create_table :executive_assigneds do |t|
      t.datetime :date_ticket_assigned

      t.timestamps
    end
  end
end
