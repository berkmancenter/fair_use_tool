require File.join(File.dirname(__FILE__), '/../../test_helper')

class UserAnswersTest < ActiveSupport::TestCase

  test "Should be able to create new instance of a portlet" do
    assert UserAnswersPortlet.create!(:name => "New Portlet")
  end
  
end