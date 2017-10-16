require 'test_helper'

class CategorieTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  test "should not save categorie without nom" do
    categorie = Categorie.new
    assert_not categorie.save
  end

  test "save categorie" do
    categorie = Categorie.new(nom: "Environnement")
    assert categorie.save
  end
end
