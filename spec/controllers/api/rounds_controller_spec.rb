require 'rails_helper'

RSpec.describe Api::RoundsController, type: :controller do

  describe '#index' do
    let(:user) { Fabricate :user }
    before { sign_in user }

    let!(:rounds) { [
      Fabricate(:round),
      Fabricate(:round)
    ] }
    before {
      rounds.each {|r| r.games << Fabricate(:game) }
    }

    let(:request) { -> { get :index } }

    it 'should render json' do
      request.call
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.keys).to include('rounds')
      expect(json.keys).to include('games')
      expect(json.keys).to include('teams')
    end
  end
end
