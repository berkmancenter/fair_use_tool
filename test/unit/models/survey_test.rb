require File.join(File.dirname(__FILE__), '/../../test_helper')

class SurveyTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Survey.create!
  end
  
end