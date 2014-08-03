class JoinNotificatorsWithProjects < ActiveRecord::Migration
  def change
    remove_column :payloads, :project_id
    create_join_table :notificators, :projects do |t|
      t.index :notificator_id
      t.index :project_id
    end
  end
end
