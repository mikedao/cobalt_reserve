class HeroesController < ApplicationController
  def index
    @heroes = current_campaign.heroes if current_campaign
  end
end
