class WorldNewsController < ApplicationController
  def index
    @world_news = current_campaign.world_news
  end

  def show
    @world_news = WorldNews.find(params[:id])
  end
end
