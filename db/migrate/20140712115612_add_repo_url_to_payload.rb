class AddRepoUrlToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :repo_url, :string
  end
end
