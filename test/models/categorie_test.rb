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

  test "search categorie function" do
    categorie1 = Categorie.new(nom: "Environnement")
    categorie2 = Categorie.new(nom: "Envie")
    categorie1.save
    categorie2.save
    assert_equal 1, Categorie.search("Environnement").count, "Categorie by name not found"
    assert_equal 1, Categorie.search("environnement").count, "Categorie with lower case name not found"
    assert_equal 1, Categorie.search("ENVIRONNEMENT").count, "Categorie with upper case name not found"
    assert_equal 1, Categorie.search("Environ").count, "Categorie with part of the name not found"
    assert_equal 0, Categorie.search("Social").count, "Categorie that doesn't have a matching name found"
    assert_equal 2, Categorie.search("Env").count, "Not all categories with good name found"
  end
end
