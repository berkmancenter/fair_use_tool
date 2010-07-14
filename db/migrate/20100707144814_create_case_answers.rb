class CreateCaseAnswers < ActiveRecord::Migration
  def self.up
    create_content_table :case_answers do |t|
      t.integer :case_id 
      t.integer :answer_id 
      t.integer :survey_id 
      t.datetime :created_at 
      t.datetime :updated_at 
    end
    
    
    ContentType.create!(:name => "CaseAnswer", :group_name => "CaseAnswer")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'CaseAnswer'])
    CategoryType.all(:conditions => ['name = ?', 'Case Answer']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :case_answer_versions
    drop_table :case_answers
  end
end
