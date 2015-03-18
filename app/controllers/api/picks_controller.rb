class Api::PicksController < ApiController
  def create
    pick_params = params[:pick]

    pick = Pick.new(user_id: current_user.id,
                    game_id: pick_params[:game_id],
                    team_id: pick_params[:team_id])

    if pick.save
      render json: PickSerializer.new(pick)
    else
      render json: {errors:pick.errors}
    end
  end
end
