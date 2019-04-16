require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '.create' do
    let(:group) { create :group }
    let(:event) { create :event, group: group }

    subject { post :create, params: { event: params }, format: :html }

    before do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      context 'with non repeatable event' do
        let!(:params) { event.attributes.except('id').merge(type: 'no') }

        it { expect { subject }.to change { Event.count }.by(1) }
      end

      context 'with repeatable event' do
        let!(:params) { event.attributes.except('id').merge(type: 'week', days: ["", "2","4"], repeat_number: 10) }

        it { expect { subject }.to change { Event.count }.by(10) }
      end
    end
  end
end
