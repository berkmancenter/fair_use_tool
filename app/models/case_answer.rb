class CaseAnswer < ActiveRecord::Base
  acts_as_content_block
  belongs_to :case
  belongs_to :answer  
  belongs_to :survey
  has_one :question, :through => :answer
  before_create :append_name, :publish
  
  # build out a pretty name for the cms to display in its listing
  def append_name
    self.name = "#{self.survey.name}: #{self.case.title}: #{self.answer.content}"
  end
  
  # its a drag to press the publish button every time. fast-publish every answer; 
  # we'll always want them immediately
  def publish
    self.published = true
  end
  
end
