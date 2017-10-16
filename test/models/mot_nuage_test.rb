require 'test_helper'

class MotNuageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save mot nuage without mot and poids" do
    mot_nuage = MotNuage.new
    assert_not mot_nuage.save
  end
end
