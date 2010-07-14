class UserAnswer < ActiveRecord::Base
  acts_as_content_block
  named_scope :user, lambda { |user|
   { :conditions => { :user_id => user.id } }
  }
  belongs_to :answer
  belongs_to :user
  belongs_to :survey
  belongs_to :case
  has_one :question, :through => :answer
  before_create :append_name
  validates_presence_of :answer_id, :survey_id  
  
  # build out a pretty name for the cms to display in its listing
  def append_name
    self.name = "Guest Answer: #{self.survey.name}: #{self.answer.content}"
  end
    
end
