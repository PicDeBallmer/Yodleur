# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171012132426) do

  create_table "categories", force: :cascade do |t|
    t.string   "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commentaires", force: :cascade do |t|
    t.text     "texte"
    t.datetime "date"
    t.integer  "plus"
    t.integer  "moins"
    t.integer  "sujet_id"
    t.integer  "auteur_id"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "commentaires", ["auteur_id"], name: "index_commentaires_on_auteur_id"
  add_index "commentaires", ["parent_id"], name: "index_commentaires_on_parent_id"
  add_index "commentaires", ["sujet_id"], name: "index_commentaires_on_sujet_id"

  create_table "delegations", force: :cascade do |t|
    t.integer  "donneur_id"
    t.integer  "receveur_id"
    t.integer  "categorie_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    # t.integer  "rec_profondeur"
    # t.integer  "rec_racine_id"
  end

  add_index "delegations", ["categorie_id"], name: "index_delegations_on_categorie_id"
  add_index "delegations", ["donneur_id", "categorie_id"], name: "index_delegations_on_donneur_id_and_categorie_id", unique: true
  add_index "delegations", ["donneur_id"], name: "index_delegations_on_donneur_id"
  # add_index "delegations", ["rec_racine_id"], name: "index_delegations_on_rec_racine_id"
  add_index "delegations", ["receveur_id"], name: "index_delegations_on_receveur_id"

  create_table "groupes", force: :cascade do |t|
    t.string   "titre"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "date_debut"
    t.datetime "date_fin"
    t.integer  "categorie_principale_id"
    t.integer  "categorie_secondaire_id"
    t.integer  "lieu_id"
  end

  create_table "lieus", force: :cascade do |t|
    t.string   "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mot_nuages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "mot"
    t.integer  "poids"
  end

  create_table "sujets", force: :cascade do |t|
    t.string   "titre"
    t.text     "description"
    t.binary   "image"
    t.string   "etat"
    t.datetime "date_creation"
    t.integer  "votes_pour"
    t.integer  "votes_contre"
    t.integer  "votes_blancs"
    t.integer  "createur_id"
    t.integer  "parent_id"
    t.integer  "groupe_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "sujets", ["createur_id"], name: "index_sujets_on_createur_id"
  add_index "sujets", ["groupe_id"], name: "index_sujets_on_groupe_id"
  add_index "sujets", ["parent_id"], name: "index_sujets_on_parent_id"

  create_table "utilisateurs", force: :cascade do |t|
    t.string   "nom"
    t.string   "prenom"
    t.string   "mail"
    t.integer  "droits"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_digest"
    t.integer  "civilite"
    t.date     "date_de_naissance"
    t.integer  "lieu_id"
    t.string   "image"
    t.string   "lieu_de_naissance"
  end

  add_index "utilisateurs", ["lieu_id"], name: "index_utilisateurs_on_lieu_id"

  create_table "votes", id: false, force: :cascade do |t|
    t.integer "sujet_id"
    t.integer "utilisateur_id"
  end

  add_index "votes", ["sujet_id", "utilisateur_id"], name: "index_votes_on_sujet_id_and_utilisateur_id", unique: true
  add_index "votes", ["sujet_id"], name: "index_votes_on_sujet_id"
  add_index "votes", ["utilisateur_id"], name: "index_votes_on_utilisateur_id"

end
