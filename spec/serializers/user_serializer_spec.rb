require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { Fabricate :user }
  let(:serializer) { UserSerializer.new(user) }
  let(:serialized) { serializer.as_json }

  subject { serialized }
  its(:keys) { should include('users') }

  context 'serialized user' do
    subject { serialized['users'][0] }

    its(:keys) { should include('id') }
    its(:keys) { should include('name') }
    its(:keys) { should include('email') }
  end
end
