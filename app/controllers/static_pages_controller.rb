class StaticPagesController < ApplicationController
  def show
    @campaign = Campaign.find_by(status: "active")
  end
end
