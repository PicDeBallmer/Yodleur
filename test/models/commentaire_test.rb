require 'test_helper'

class CommentaireTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  test "should not save commentaire without sujet and auteur" do
    commentaire = Commentaire.new
    assert_not commentaire.save
  end
end
