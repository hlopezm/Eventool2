class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.boolean :finish
      t.string :title
      t.string :description, limit: 400
      t.timestamps
      t.references :event
    end
  end
end
