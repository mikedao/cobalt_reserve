class Admin::WorldNewsController < Admin::BaseController
  before_action :require_admin

  def new
    @world_news = WorldNews.new
  end

  def create
    current_campaign.world_news.create(world_news_params)
    redirect_to admin_world_news_index_path
  end

  def index
    @world_news = current_campaign.world_news
  end

  private

    def world_news_params
      params.require(:world_news).permit(:title, :date, :body)
    end
end
