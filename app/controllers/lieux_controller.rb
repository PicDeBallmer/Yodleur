class LieuxController < ApplicationController
  before_action :require_admin

  def index
    @lieux = Lieu.all
  end

  def create
    @lieu = Lieu.new(lieux_params)
    @lieu.save
    redirect_to lieux_index_path
  end

  def destroy
    @lieu = Lieu.find_by_id(params[:id])
    @lieu.destroy
    redirect_to lieux_index_path
  end

  private
    def lieux_params
      params.require(:lieu).permit(
        :nom
      )
    end

end
