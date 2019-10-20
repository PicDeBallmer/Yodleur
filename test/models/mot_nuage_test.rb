require 'test_helper'

class MotNuageTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  test "should not save mot nuage without mot and poids" do
    mot_nuage = MotNuage.new
    assert_not mot_nuage.save
  end

  test "should not save mot nuage without mot" do
    mot_nuage = MotNuage.new(poids: 20)
    assert_not mot_nuage.save
  end

  test "should not save mot nuage without poids" do
    mot_nuage = MotNuage.new(mot: 'Barbiche')
    assert_not mot_nuage.save
  end

  test "save mot nuage" do
    mot_nuage = MotNuage.new(mot: 'Barbiche', poids: 20)
    assert mot_nuage.save
  end
end
