class CreateBooks < ActiveRecord::Migration[5.2]
    def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :price
      t.integer :page_num
    end
  end
end
