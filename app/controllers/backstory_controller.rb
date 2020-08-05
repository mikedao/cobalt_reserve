class BackstoryController < ApplicationController
  def edit
    redirect_to root_path unless current_user
    @character = Character.find(params[:id])
  end

  def update
    character = Character.find(params[:id])
    character.update(character_params)
    redirect_to character_path(character)
  end

  private

  def character_params
    params.require(:character)
          .permit(:age,
                  :early_life,
                  :moral_code,
                  :personality,
                  :fears,
                  :role,
                  :additional_information)
  end
end
