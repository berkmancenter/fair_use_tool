class DropBonusParentIdQuestions < ActiveRecord::Migration
  def self.up
    remove_column :questions, :parent_id
    remove_column :questions, :bonus
    remove_column :question_versions, :parent_id
    remove_column :question_versions, :bonus
  end

  def self.down
    add_column :questions, :parent_id, :integer
    add_column :questions, :bonus, :boolean
    add_column :question_versions, :parent_id, :integer
    add_column :question_versions, :bonus, :boolean
  end
end
