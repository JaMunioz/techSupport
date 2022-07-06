class AddUserRefToExecutiveAssigned < ActiveRecord::Migration[7.0]
  def change
    add_reference :executive_assigneds, :user, null: false, foreign_key: true
  end
end
