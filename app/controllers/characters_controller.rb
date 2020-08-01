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
    if @character&.user != current_user
      flash[:error] = 'The character you tried to edit is invalid'
      redirect_to profile_path and return
    end

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
    if current_user.active_campaign_character.nil?
      @character.active = true
    end

    if @character.save
      redirect_to profile_path and return
    else
      render :new and return
    end
  end

  def update
    character = Character.find(params[:id])
    if character&.user != current_user
      flash[:error] = 'The character you tried to edit is invalid'
      redirect_to profile_path and return
    end
    @user = character.user

    p = character_params
    p[:user] = current_user
    p[:campaign] = Campaign.current

    prep_form_data
    character.update(p)
    if character.save
      redirect_to profile_path and return
    else
      @character = character
      @form_submission_url = user_character_path(@user, @character)
      render :edit and return
    end
  end

  def activate
    character = Character.find(params[:id])
    if character&.user != current_user
      flash[:error] = 'The character you tried to activate is invalid'
      redirect_to profile_path and return
    end
    @user = character.user
    @user.characters.update(active: false)
    character.update(active: true)
    flash[:success] = "#{character.name} is now active!"
    redirect_to profile_path and return
  end

  private

  def prep_form_data
    @character = Character.new
    @user = current_user
    @species = Culture.order(:name)
    @form_submission_url = user_characters_path(@user, @character)
    @classes = Character.classes
  end

  def character_params
    params.require(:character).permit(:name, :level, :klass, :ancestryone_id, :culture_id, :dndbeyond_url)
  end
end