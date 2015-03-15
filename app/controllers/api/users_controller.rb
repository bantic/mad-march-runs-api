class Api::UsersController < ApiController
  def show
    user = User.find params[:id]
    render json: UserSerializer.new(user)
  end

  def update
    user = User.find params[:id]
    team_ids = params[:user] && params[:user][:team_ids] || []
    teams = Team.find(team_ids)
    user.teams = teams
    user.save!
    render json: UserSerializer.new(user)
  end
end
