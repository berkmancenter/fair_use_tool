require File.join(File.dirname(__FILE__), '/../../test_helper')

class QuestionTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Question.create!
  end
  
end