class CreateUserAnswers < ActiveRecord::Migration
  def self.up
    create_content_table :user_answers do |t|
      t.integer :user_id 
      t.integer :case_id 
      t.integer :answer_id 
      t.integer :survey_id 
      t.datetime :created_at 
      t.datetime :updated_at 
    end
    
    
    ContentType.create!(:name => "UserAnswer", :group_name => "UserAnswer")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'UserAnswer'])
    CategoryType.all(:conditions => ['name = ?', 'User Answer']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :user_answer_versions
    drop_table :user_answers
  end
end
