class AddSessionIdUserAnswer < ActiveRecord::Migration
  def self.up
    add_column :user_answers, :session_id, :string
  end

  def self.down
    remove_column :user_answers, :session_id
  end
end
