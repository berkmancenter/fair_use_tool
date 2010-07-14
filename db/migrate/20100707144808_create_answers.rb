class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_content_table :answers do |t|
      t.string :content 
      t.integer :question_id 
      t.integer :parent_id 
      t.integer :order 
      t.float :value 
      t.datetime :created_at 
      t.datetime :updated_at 
      t.boolean :tiebreaker 
    end
    
    
    ContentType.create!(:name => "Answer", :group_name => "Answer")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Answer'])
    CategoryType.all(:conditions => ['name = ?', 'Answer']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :answer_versions
    drop_table :answers
  end
end
