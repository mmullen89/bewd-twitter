class AddTimeStampsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :timestamps, :datetime
  end
end
