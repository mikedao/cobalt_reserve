class CharactersController < ApplicationController
  def index
    @character_list = Character.distinct.where(active: true, campaign: Campaign.current)
  end
end