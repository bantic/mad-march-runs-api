class Api::UsersController < ApiController
  skip_before_filter :authenticate_user!, only: :create

  def show
    user = User.find params[:id]
    render json: UserSerializer.new(user)
  end

  def create
    user_params = params[:user] || {}
    user_data = {
      email: user_params[:email],
      password: user_params[:password]
    }
    user = User.new(user_data)

    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: {errors: user.errors}, status: 422
    end
  end

  def update
    user = current_user

    if Time.zone.now <= User::TOURNEY_START_TIME
      team_ids = params[:user] && params[:user][:team_ids] || []
      teams = Team.find(team_ids)
      user.teams = teams
    end

    user.save!
    render json: UserSerializer.new(user)
  end
end
