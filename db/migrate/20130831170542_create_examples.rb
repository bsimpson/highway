class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.text :route
      t.string :grep
      t.string :slug
      t.timestamps
    end

    add_index :examples, :slug, unique: true
  end
end
