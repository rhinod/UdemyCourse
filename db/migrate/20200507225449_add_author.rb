class AddAuthor < ActiveRecord::Migration[6.0]

  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    add_column :articles, :author, :string
  end
end
