require File.join(File.dirname(__FILE__), '/../../test_helper')

class UserAnswerTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert UserAnswer.create!
  end
  
end