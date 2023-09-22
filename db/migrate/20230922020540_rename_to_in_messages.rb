class RenameToInMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :to, :recipient_phone
  end
end
