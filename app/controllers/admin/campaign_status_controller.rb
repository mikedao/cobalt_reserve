class Admin::CampaignStatusController < Admin::BaseController
  def update
    current_campaign.update(status: 'inactive')
    new_current = Campaign.find(params[:id])
    new_current.update(status: 'active')
    @current_campaign = new_current
    redirect_to admin_campaigns_path
  end
end
