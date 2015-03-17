class Api::RoundsController < ApplicationController
  def index
    rounds = Round.all
    render json: rounds, each_serializer: RoundSerializer
  end
end
