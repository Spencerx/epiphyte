class AddNotificatorToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :notificator_id, :string, index: true
  end
end
