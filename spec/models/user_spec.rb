require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should check email uniqueness' do
      email = 'abcDEF@gmail.com'

      Fabricate :user, email: email

      expect( Fabricate.build(:user, email:email).save ).to be false
      expect( Fabricate.build(:user, email:'abcdef@gmail.com').save ).to be false
    end
  end

  describe '#teams' do
    let(:user) { Fabricate :user, teams:[] }

    it 'should allow 3 teams' do
      3.times do
        user.teams << Fabricate(:team)
      end
      expect(user.save).to be true
    end

    it 'should error after 3 teams' do
      3.times do
        user.teams << Fabricate(:team)
      end
      expect(user.teams.count).to eql(3)
      user.teams << Fabricate(:team)
      expect(user.save).not_to be true
      expect(user.errors.messages[:base]).to include('cannot have more than 3 teams')
    end
  end
end
