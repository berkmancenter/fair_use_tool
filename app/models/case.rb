class Case < ActiveRecord::Base
  acts_as_content_block
  has_many :case_answers
  has_many :user_answers
  belongs_to :survey
  belongs_to :user
  belongs_to :original_resource, :class_name => "ImageBlock", :foreign_key => "original_resource_id"
  belongs_to :derivative_resource, :class_name => "ImageBlock", :foreign_key => "derivative_resource_id"
  
  accepts_nested_attributes_for :original_resource, :reject_if => lambda { |a| a["uploaded_data"].nil? }, :allow_destroy => true
  accepts_nested_attributes_for :derivative_resource, :reject_if => lambda { |a| a["uploaded_data"].nil? }, :allow_destroy => true
  
  before_create :append_name

  # build out a pretty name for the cms to display in its listing
  def append_name
    self.name = self.title
  end
    
  # return true|false for whether or not this case has had it's survey filled out
  def finished_survey?(user)
    case_answers = self.user_case_answers(user)
    return case_answers.nil? ? false : case_answers.length == self.survey.questions.with_answers.length
  end
  
  # return all the user_answers for this case and some particular user.
  def user_case_answers(user)
    return UserAnswer.find(:all, :conditions => {:case_id => self.id, :user_id => user.id})
  end
end
