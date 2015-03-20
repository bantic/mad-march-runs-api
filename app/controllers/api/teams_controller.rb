class Api::TeamsController < ApiController
  def index
    teams = Team.all
    render json: teams, each_serializer: TeamSerializer
  end

  def show
    team = Team.find(params[:id]);
    render json: TeamSerializer.new(team)
  end
end
