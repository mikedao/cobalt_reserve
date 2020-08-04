class Admin::GameSessionsController < Admin::BaseController
  before_action :require_admin

  def new
    @game_session = GameSession.new
  end

  def create
    unless game_session_params[:characters]
      flash[:error] = 'You must select at least one character.'
      redirect_back fallback_location: admin_game_sessions_new_path and return
    end

    game_session = Campaign.current.game_sessions.new(name: game_session_params[:name],
                                                      date: Date.today)
    if game_session.save
      game_session_params[:characters].each do |character_id|
        GameSessionCharacter.create!(game_session_id: game_session.id,
                                     character_id: character_id.to_i)
      end
      flash[:success] = 'Your game session was created.'
      redirect_to game_session_path(game_session) and return
    else
      flash[:error] = game_session.errors.full_messages.join(', ')
      redirect_back fallback_location: admin_game_sessions_new_path
    end
  end

  private

  def game_session_params
    { name: params[:game_session][:name],
      characters: params[:game_session][:characters] }
  end
end
