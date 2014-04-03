class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :title
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
      t.references :event
      t.references :user
      t.references :invitation
    end
  end
end
