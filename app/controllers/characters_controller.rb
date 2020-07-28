class CharactersController < ApplicationController
  def index
    @characters = Character.where(campaign: Campaign.current)
  end
end