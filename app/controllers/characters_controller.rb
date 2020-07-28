class CharactersController < ApplicationController
  def index
    @character_list = Character.distinct.where(active: true, campaign: Campaign.current)
  end

  def new
    @character = Character.new
    @user = current_user
    @species = Character.species
    @classes = Character.classes
  end

  def create
    p = character_params
    p[:user] = current_user
    p[:campaign] = Campaign.current
    current_user.characters.create!(p)

    redirect_to profile_path
  end

  private

  def character_params
    params.require(:character).permit(:name, :level, :character_class, :species)
  end
end