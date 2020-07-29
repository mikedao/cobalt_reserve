class GameSessionsController < ApplicationController
  def show
    @game_session = GameSession.find(params[:id])
  end
end
