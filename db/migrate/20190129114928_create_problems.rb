class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :title
      t.string :statement
      t.string :answer
      t.int :level
      t.timestamps
    end
  end
end
