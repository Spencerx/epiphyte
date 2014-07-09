class CreateNotificator < ActiveRecord::Migration
  def change
    create_table :notificators do |t|
      t.string :name
      t.string :notifying_host
    end
  end
end
