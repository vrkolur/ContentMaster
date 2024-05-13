class AddStatusToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :status, :boolean, default: false
  end
end
