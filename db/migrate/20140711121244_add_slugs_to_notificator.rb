class AddSlugsToNotificator < ActiveRecord::Migration

  def change
    add_column :notificators, :slug, :string
    add_index :notificators, :slug, :unique => true
  end

end
