class Answer < ActiveRecord::Base
  acts_as_content_block
  belongs_to :question
  before_create :append_name, :publish
  before_save :append_name

  # build out a pretty name for the cms to display in its listing
  def append_name
    self.name = self.question.content+": "+self.content
  end

  # its a drag to press the publish button every time. fast-publish every answer; 
  # we'll always want them immediately
  def publish
    self.published = true
  end

  # return the class name used for css of areas where results are shown
  def color_classification
    if self.value > 0
      return "positive"
    elsif self.value == 0
      return "neutral"
    else return "negative"
    end
  end
  
  # scorecard values for an answer's raw .value
  def green_red_values
    if self.value > 0
      return 1, 0
    elsif self.value == 0
      return 0.5, 0.5
    else return 0, 1
    end
  end
end
