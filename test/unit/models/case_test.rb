require File.join(File.dirname(__FILE__), '/../../test_helper')

class CaseTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Case.create!
  end
  
end