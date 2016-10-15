module SessionsHelper

  def log_in(utilisateur)
    session[:utilisateur_id] = utilisateur.id
  end

  def utilisateur_courant
    @utilisateur_courant ||= Utilisateur.find_by_id(session[:utilisateur_id]) if session[:utilisateur_id]
  end

  def logged_in?
    !utilisateur_courant.nil?
  end

  def log_out
    session.delete(:utilisateur_id)
    @utilisateur_courant = nil
  end

  def admin?
    logged_in? && utilisateur_courant.admin?
  end

  def utilisateur_courant?(utilisateur)
    utilisateur_courant == utilisateur
  end

  def utilisateur_courant_ou_admin?(utilisateur)
    utilisateur_courant?(utilisateur) || admin?
  end

end
