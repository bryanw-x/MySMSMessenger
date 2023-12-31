class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :text, null: false
      t.string :recipient_phone, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
