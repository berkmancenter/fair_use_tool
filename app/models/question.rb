class Question < ActiveRecord::Base
  acts_as_content_block
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a['content'].blank? }, :allow_destroy => true
  named_scope :with_answers, :joins => :answers, :group => 'questions.id', :conditions => ['questions.id = answers.question_id']
  named_scope :order, :order => "order"
  before_create :append_name, :publish
  validates_uniqueness_of :order, :scope => :survey_id

  # build out a pretty name for the cms to display in its listing
  def append_name
    self.name = self.content
  end
  
  # its a drag to press the publish button every time. fast-publish every answer; 
  # we'll always want them immediately
  def publish
    self.published = true
  end

end
