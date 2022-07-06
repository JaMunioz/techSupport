class CreateExecutiveReports < ActiveRecord::Migration[7.0]
  def change
    create_table :executive_reports do |t|
      t.float :calification
      t.datetime :date

      t.timestamps
    end
  end
end
