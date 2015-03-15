require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let!(:user) { Fabricate :user }

  before { sign_in user }

  describe '#show' do
    let(:request) { -> { get :show, {id: user.id} } }

    subject { request.call }
    it { should serialize_to(UserSerializer, user) }
  end

  describe '#update' do
    let(:team) { Fabricate :team }
    let(:params) { {
      id: user.id,
      user: {team_ids:[team.id]}
    } }
    let(:request) { -> { put :update, params } }

    context 'user has no teams' do
      before { user.teams.clear; user.save! }

      it { expect(request).to change(user.teams, :count).by(1) }
    end

    context 'user has teams' do
      it { expect(user.teams).not_to be_empty }
      it 'should replace user teams' do
        request.call
        expect(user.reload.teams.to_a).to eql([team])
      end
    end
  end

  describe '#create' do
    before { sign_out user }
    let(:params) { {
      user: {
        email: 'abc@gmail.com',
        password: 'sdflkjsdh'
      }
    } }
    let(:request) { -> { post :create, params } }

    it { expect(request).to change(User, :count).by(1) }
    it 'should create user with params' do
      request.call
      user = User.last
      expect(user.email).to eql('abc@gmail.com')
    end

    context 'email is taken' do
      let!(:existing_user) { Fabricate :user }
      let(:params) { {
        user: {
          email: existing_user.email,
          password: 'lskjdflskjd'
        }
      } }

      it { expect(request).not_to change(User, :count) }
      it 'should have errors in response' do
        request.call
        json = JSON.parse(response.body)

        expect(json['errors']).to be_present
        expect(json['errors']['email']).to be_present
        expect(json['errors']['email'][0]).to include('has already been taken')
      end
    end
  end
end
