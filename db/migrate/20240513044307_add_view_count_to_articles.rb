class AddViewCountToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :view_count, :integer, default: 0
  end
end
