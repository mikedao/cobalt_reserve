class Admin::CampaignsController < Admin::BaseController
  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    campaign = Campaign.find(params[:id])
    campaign.update(campaign_params)
    redirect_to admin_campaign_path(campaign)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    Campaign.create(campaign_params)
    redirect_to admin_campaigns_path
  end

  def destroy
    Campaign.find(params[:id]).destroy
    redirect_to admin_campaigns_path
  end

  private

    def campaign_params
      params.require(:campaign).permit(:name)
    end
end
