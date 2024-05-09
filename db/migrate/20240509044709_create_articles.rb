class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.text :body
      t.references :client, null: false, foreign_key: true
      t.references :client_user, null: false, foreign_key: true
      t.boolean :status, default: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
