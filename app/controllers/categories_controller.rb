class CategoriesController < ApplicationController
  before_action :require_admin

  def index
    @categories = Categorie.all
  end

  def create
    @categorie = Categorie.new(categories_params)
    @categorie.save
    redirect_to categories_path
  end

  def destroy
    @categorie = Categorie.find_by_id(params[:id])
    @categorie.destroy
    redirect_to categories_path
  end

  private
  def categories_params
    params.require(:categorie).permit(
        :nom
    )
  end
end
