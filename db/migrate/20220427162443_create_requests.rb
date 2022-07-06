class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :request
      t.datetime :date_request

      t.timestamps
    end
  end
end
