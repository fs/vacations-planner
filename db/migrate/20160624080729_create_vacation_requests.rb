class CreateVacationRequests < ActiveRecord::Migration
  def change
    create_table :vacation_requests do |t|
      t.integer :starts_at_week
      t.integer :ends_at_week
      t.references :user
    end
  end
end
