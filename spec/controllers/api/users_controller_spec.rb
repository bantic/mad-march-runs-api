require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe '#show' do
    let!(:user) { Fabricate :user }
    let(:request) { -> { get :show, {id: user.id} } }

    subject { request.call }
    it { should serialize_to(UserSerializer, user) }
  end
end
