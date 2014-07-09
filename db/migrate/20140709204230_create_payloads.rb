class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :blob
    end
  end
end
