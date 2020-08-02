class AdventureLogsController < ApplicationController
  def new
    @game_session = GameSession.find(params[:game_session_id])
    @adventure_log = AdventureLog.new
  end

  def create
    AdventureLog.create(content: content,
                        game_session_id: game_session_id,
                        character: current_user.active_campaign_character)
    redirect_to game_session_path(game_session_id)
  end

  private

  def game_session_id
    params[:game_session_id]
  end

  def content
    params[:adventure_log][:content]
  end
end
