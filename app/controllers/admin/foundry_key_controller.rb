class Admin::FoundryKeyController < Admin::BaseController
  before_action :require_admin

  def index
    @characters = Character.active
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    character = Character.find(params[:id])
    character.update(foundry_key_params)
    redirect_to admin_foundry_key_path
  end

  private

    def foundry_key_params
      params.require(:character).permit(:foundry_key)
    end
end
