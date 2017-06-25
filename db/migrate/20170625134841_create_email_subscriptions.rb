class CreateEmailSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :email_subscriptions do |t|
      t.string :email
      t.string :key
      t.boolean :confirmed

      t.timestamps
    end
  end
end
