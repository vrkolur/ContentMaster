class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :sub_domain
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
