require File.join(File.dirname(__FILE__), '/../../test_helper')

class CaseAnswerTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert CaseAnswer.create!
  end
  
end