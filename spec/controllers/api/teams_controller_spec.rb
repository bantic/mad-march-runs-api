require 'rails_helper'

RSpec.describe Api::TeamsController, type: :controller do
  describe '#show' do
    let(:user) { Fabricate(:user) }
    before { sign_in user }
    let(:team) { Fabricate(:team) }

    let(:request) { -> { get :show, id:team.id } }

    it 'should render json' do
      request.call
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.keys).to include('team')

      team_json = json['team']
      expect(team_json['id']).to eql team.id
    end
  end
end
