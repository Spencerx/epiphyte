class AddRequestHostToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :request_host, :string
  end
end
