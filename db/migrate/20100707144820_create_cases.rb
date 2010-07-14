class CreateCases < ActiveRecord::Migration
  def self.up
    create_content_table :cases do |t|
      t.integer :original_resource_id 
      t.integer :derivative_resource_id 
      t.text :facts 
      t.integer :survey_id 
      t.integer :user_id 
      t.string :title 
      t.datetime :created_at 
      t.datetime :updated_at 
    end
    
    
    ContentType.create!(:name => "Case", :group_name => "Case")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Case'])
    CategoryType.all(:conditions => ['name = ?', 'Case']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :case_versions
    drop_table :cases
  end
end
