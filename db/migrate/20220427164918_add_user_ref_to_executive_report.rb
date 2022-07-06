class AddUserRefToExecutiveReport < ActiveRecord::Migration[7.0]
  def change
    add_reference :executive_reports, :user, null: false, foreign_key: true
  end
end
