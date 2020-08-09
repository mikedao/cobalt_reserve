class AdventureLogsController < ApplicationController
  def new
    @game_session = GameSession.find(params[:game_session_id])
    @adventure_log = AdventureLog.new
  end

  def create
    adventure_log = AdventureLog.new(content: content,
                                     game_session_id: game_session_id,
                                     character: current_user.active_campaign_character)
    if adventure_log.save
      flash[:success] = 'Your adventure log was created.'
      redirect_to game_session_path(game_session_id) and return
    else
      flash[:error] = adventure_log.errors.full_messages.join(', ')
      redirect_back fallback_location: new_game_session_adventure_log_path(game_session_id)
    end
  end

  def update
    adventure_log = AdventureLog.find(adventure_log_id)
    adventure_log.toggle(:best)
    redirect_to game_session_path(game_session_id)
  end

  private

  def game_session_id
    params[:game_session_id]
  end

  def adventure_log_id
    params[:id]
  end

  def content
    params[:adventure_log][:content]
  end
end
