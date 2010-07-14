class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_content_table :surveys do |t|
      t.string :name 
      t.datetime :created_at 
      t.datetime :updated_at 
    end
    
    
    ContentType.create!(:name => "Survey", :group_name => "Survey")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Survey'])
    CategoryType.all(:conditions => ['name = ?', 'Survey']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :survey_versions
    drop_table :surveys
  end
end
