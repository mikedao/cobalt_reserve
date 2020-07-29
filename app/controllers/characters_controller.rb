class CharactersController < ApplicationController
  def index
    @character_list = Character.distinct.where(active: true, campaign: Campaign.current)
  end

  def new
    prep_form_data
  end

  def edit
    prep_form_data
    @character = Character.find(params[:id])
    @form_submission_url = user_character_path(@user, @character)
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

  def update
    p = character_params
    p[:user] = current_user
    p[:campaign] = Campaign.current

    # prep_form_data
    @character = current_user.characters.update(p)
    # if @character.save
      redirect_to profile_path and return
    # else
    #   render :new and return
    # end
  end

  private

  def prep_form_data
    @character = Character.new
    @user = current_user
    @form_submission_url = user_characters_path(@user, @character)
    @species = Character.species
    @classes = Character.classes
  end

  def character_params
    params.require(:character).permit(:name, :level, :character_class, :species)
  end
end