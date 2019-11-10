require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test_level" do
    user = User.first
    puts user.test_list_on_level(0)
    assert 0 == 0
  end
end
