class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :sender
      t.datetime :delivered_at
      t.string :receiver
      t.datetime :confirmed_at
      t.boolean :attend
      t.boolean :substitute
      t.string :notes
      t.timestamps
      t.references :event
      t.references :user
      t.references :guest
    end
  end
end
