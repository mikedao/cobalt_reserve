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

  def show
    @world_news = WorldNews.find(params[:id])
  end

  def destroy
    WorldNews.find(params[:id]).destroy
    redirect_to admin_world_news_index_path
  end

  def edit
    @world_news = WorldNews.find(params[:id])
  end

  def update
    WorldNews.find(params[:id]).update(world_news_params)
    redirect_to admin_world_news_path(params[:id])
  end

  private

    def world_news_params
      params.require(:world_news).permit(:title, :date, :body)
    end
end
