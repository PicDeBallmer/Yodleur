# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lieus = Lieu.create(
    [{nom: 'Villeurbanne'},
     {nom: 'Lyon 1'},
     {nom: 'Lyon 2'},
     {nom: 'Lyon 3'},
     {nom: 'Lyon 4'}])

p "Created #{Lieu.count} lieus"

categories = Categorie.create(
    [{nom: 'Sport'},
     {nom: 'Culture'},
     {nom: 'Numérique'},
     {nom: 'Environnement'},
     {nom: 'Social'},
     {nom: 'Education'}])

p "Created #{Categorie.count} categories"

# Only if dev
if Rails.env == 'development'

  utilisateurs = Utilisateur.create!(
      [
          {droits: 0, prenom: "Frodo", nom: "Sacquet", mail:"frodo.sacquet@shire.me", lieu: lieus[0], password: "admin1"},
          {droits: 1, prenom: "Peregrin", nom: "Touc", mail:"peregrin.touc@shire.me", lieu: lieus[0], password: "admin1"},
          {droits: 2, prenom: "Meriadoc", nom: "Brandebouc", mail:"meriadoc.brandebouc@shire.me", lieu: lieus[0], password: "admin1"}])

  p "Created #{Utilisateur.count} utilisateurs"

  groupes = Groupe.create(
      [{titre: 'Améliorer le WiFi dans les salles de TP', date_debut: DateTime.now, date_fin: DateTime.tomorrow},
       {titre: 'Installer une tireuse à bière en Gaston Berger', date_debut: DateTime.now, date_fin: DateTime.tomorrow},
       {titre: 'Planter des arbres sur les humas', date_debut: DateTime.now, date_fin: DateTime.tomorrow},
       {titre: 'Organiser un concert de Barbiche', date_debut: DateTime.yesterday, date_fin: DateTime.now}])

  p "Created #{Groupe.count} groupes"

  sujets = Sujet.create!(
      [
          {createur: utilisateurs[0], groupe: groupes[0], titre:'Améliorer le WiFi dans les salles de TP',
           description: 'Améliorer le WiFi dans les salles de TP',
           votes_blancs: 0, votes_pour: 0, votes_contre: 0},
          {createur: utilisateurs[0], groupe: groupes[1], titre:'Installer une tireuse à bière en Gaston Berger',
           description: 'Installer une tireuse à bière en Gaston Berger',
           votes_blancs: 0, votes_pour: 0, votes_contre: 0},
          {createur: utilisateurs[0], groupe: groupes[2], titre:'Planter des arbres sur les humas',
           description: 'Planter des arbres sur les humas',
           votes_blancs: 0, votes_pour: 0, votes_contre: 0},
          {createur: utilisateurs[1], groupe: groupes[3], titre:'Organiser un concert de Barbiche',
           description: 'Organiser un concert de Barbiche',
           votes_blancs: 0, votes_pour: 0, votes_contre: 0}])

  p "Created #{Sujet.count} sujets"

  mot_nuages = MotNuage.create(
      [{mot: 'Barbiche', poids: 20},
       {mot: 'INSA', poids: 10}])

  p "Created #{MotNuage.count} mot_nuages"

end
