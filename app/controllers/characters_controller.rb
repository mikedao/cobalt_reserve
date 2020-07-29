class CharactersController < ApplicationController
  def index
    @character_list = Character.distinct.where(active: true, campaign: Campaign.current)
  end

  def new
    prep_form_data
  end

  def create
    p = character_params
    p[:user] = current_user
    p[:campaign] = Campaign.current

    unless Campaign.current
      flash[:error] = 'Sorry, there is no active campaign.'
      prep_form_data
      render :new and return
    end

    prep_form_data
    @character = current_user.characters.create(p)
    if @character.save
      redirect_to profile_path and return
    else
      render :new and return
    end
  end

  private

  def prep_form_data
    @character = Character.new
    @user = current_user
    @species = Character.species
    @classes = Character.classes
  end

  def character_params
    params.require(:character).permit(:name, :level, :character_class, :species)
  end
end