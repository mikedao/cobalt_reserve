class Admin::WorldMapsController < Admin::BaseController
  def new
    @world_map = WorldMap.new
  end

  def create
    current_campaign.world_maps.create(world_maps_params)
    redirect_to admin_dashboard_path
  end

  private

    def world_maps_params
      params.require(:world_map).permit(:low_res, :high_res)
    end
end
