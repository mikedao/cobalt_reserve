class WorldMapsController < ApplicationController
  def index
    @world_maps = current_campaign.world_maps.ordered
  end
end
