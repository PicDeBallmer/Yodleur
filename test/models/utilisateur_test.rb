require 'test_helper'

class UtilisateurTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  test "should save user" do
    utilisateur = Utilisateur.new(
        nom: 'Lasalle',
        prenom: 'Jean',
        mail: 'jean.lasalle2@lourdios-ichere.fr',
        droit: 0,
        civilite: 0,
        date_de_naissance: '3-5-1955'.to_date,
        lieu: Lieu.find_by(nom: 'Villeurbanne'),
        lieu_de_naissance: 'Villeurbanne',
        password: 'motdepasse',
        password_confirmation: 'motdepasse')
    assert utilisateur.save
  end

  test "droit enum" do
    assert utilisateurs(:jeanlasalle).pelo?
    assert_not utilisateurs(:jeanlasalle).elu?
    assert_not utilisateurs(:jeanlasalle).administrateur?
    assert_not utilisateurs(:jeanlasalle).en_attente?
  end

  test "nom_complet function" do
    assert_equal 'Jean LASALLE',utilisateurs(:jeanlasalle).nom_complet
  end

  test "delegation donnee" do
    assert_not utilisateurs(:jeanlasalle).delegation_donnee?(0)
  end

  test "votes_disponibles_par_categorie" do
    assert_equal 1, utilisateurs(:jeanlasalle).votes_disponibles_par_categorie(0)
  end

  test "delegations_par_categorie" do
    assert_equal [], utilisateurs(:jeanlasalle).delegations_par_categorie(0)
  end

  test "search" do
    assert_equal 0, Utilisateur.search("Test").count, "Search Test"
    assert_equal 1, Utilisateur.search("La").count, "Search La"
    assert_equal 1, Utilisateur.search("la").count, "Search la"
    assert_equal 1, Utilisateur.search("Lasalle").count, "Search Lasalle"
    assert_equal 1, Utilisateur.search("lasalle").count, "Search lasalle"
    assert_equal 1, Utilisateur.search("Jean").count, "Search Jean"
    assert_equal 1, Utilisateur.search("jean").count, "Search jean"
    assert_equal 1, Utilisateur.search("Jean Lasalle").count, "Search Jean Lasalle"
    assert_equal 1, Utilisateur.search("Lasalle Jean").count, "Search Lasalle Jean"
  end
end
