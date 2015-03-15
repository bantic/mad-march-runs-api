class Api::TeamsController < ApiController
  def index
    teams = Team.all
    render json: teams, each_serializer: TeamSerializer
  end
end
