class AttachPayloadToProject < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.string :name
      t.timestamps
    end
    add_reference :payloads, :project, index: true
  end

end
