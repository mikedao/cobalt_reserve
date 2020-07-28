class Admin::GameSessionsController < Admin::BaseController
  before_action :require_admin

  def new
    @game_session = GameSession.new
  end

  def create
    game_session = Campaign.current.game_sessions.create!(name: game_session_params[:name])

    game_session_params[:characters].each do |character_id|
      GameSessionCharacter.create!(game_session_id: game_session.id,
                                   character_id: character_id)
    end

    redirect_to game_session_path(game_session)
  end

  private

  def game_session_params
    {name: params[:game_session][:name],
     characters: params[:game_session][:characters].map(&:to_i)}
  end
end
