require File.join(File.dirname(__FILE__), '/../../test_helper')

class AnswerTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Answer.create!
  end
  
end