class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_content_table :questions do |t|
      t.integer :survey_id 
      t.string :content 
      t.integer :parent_id 
      t.integer :order 
      t.integer :bonus 
      t.datetime :created_at 
      t.datetime :updated_at 
      t.text :explanation 
    end
    
    
    ContentType.create!(:name => "Question", :group_name => "Question")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Question'])
    CategoryType.all(:conditions => ['name = ?', 'Question']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :question_versions
    drop_table :questions
  end
end
