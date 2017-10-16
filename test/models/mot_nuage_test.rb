require 'test_helper'

class MotNuageTest < ActiveSupport::TestCase
  self.use_transactional_tests = true
  # test "the truth" do
  #   assert true
  # end
  test "should not save mot nuage without mot and poids" do
    mot_nuage = MotNuage.new
    assert_not mot_nuage.save
  end

  test "save mot nuage without mot and poids" do
    mot_nuage = MotNuage.new(mot: 'Barbiche', poids: 20)
    assert mot_nuage.save
  end
end
