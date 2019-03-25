require 'rails_helper'

RSpec.describe Events::CreateValidator do
  describe '.call' do
    let(:group) { create :group }

    subject { described_class.new(params).call }

    context 'with valid params' do
      context 'with not repeatable event' do
        let(:params) do
          { description: 'some text',
            date: Date.current,
            start_at: Time.current + 1.hour,
            end_at: Time.current + 2.hours,
            group_id: group.id,
            type: 'no' }
        end

        it { expect(subject).to eq('success') }
      end

      context 'with repeatable event' do
        let(:params) do
          { description: 'some text',
            date: Date.current,
            start_at: Time.current + 1.hour,
            end_at: Time.current + 2.hours,
            group_id: group.id,
            type: 'week',
            repeat_number: 5,
            days: ["", "2", "4"]}
        end

        it { expect(subject).to eq('success') }
      end
    end

    context 'with invalid params' do
      context 'with wrong params for repeatable events' do
        context 'without days' do
          let(:params) do
            { description: 'some text',
              date: Date.current,
              start_at: Time.current + 1.hour,
              end_at: Time.current + 2.hours,
              group_id: group.id,
              type: 'week',
              days: nil,
              repeat_number: 5 }
          end

          it { expect(subject).to eq("Выберите дни недели") }
        end

        context 'without repeat_number' do
          let(:params) do
            { description: 'some text',
              date: Date.current,
              start_at: Time.current + 1.hour,
              end_at: Time.current + 2.hours,
              group_id: group.id,
              type: 'week',
              days: ["2", "4"],
              repeat_number: nil }
          end

          it { expect(subject).to eq("Введите количество повторений") }
        end
      end

      context 'with wrong main params' do
        context 'without description' do
          let(:params) do
            { description: nil,
              date: Date.current,
              start_at: Time.current + 1.hour,
              end_at: Time.current + 2.hours,
              group_id: group.id,
              type: 'no' }
          end

          it { expect(subject).to eq("can't be blank") }
        end

        context 'without date' do
          let(:params) do
            { description: 'some text',
              date: nil,
              start_at: Time.current + 1.hour,
              end_at: Time.current + 2.hours,
              group_id: group.id,
              type: 'no' }
          end

          it { expect(subject).to eq("can't be blank") }
        end

        context 'without start_at' do
          let(:params) do
            { description: 'some text',
              date: Date.current,
              start_at: nil,
              end_at: Time.current + 2.hours,
              group_id: group.id,
              type: 'no' }
          end

          it { expect(subject).to eq("can't be blank") }
        end

        context 'without end_at' do
          let(:params) do
            { description: 'some text',
              date: Date.current,
              start_at: Time.current + 1.hour,
              end_at: nil,
              group_id: group.id,
              type: 'no' }
          end

          it { expect(subject).to eq("can't be blank") }
        end

        context 'without group' do
          let(:params) do
            { description: 'some text',
              date: Date.current,
              start_at: Time.current + 1.hour,
              end_at: Time.current + 1.hour,
              group_id: nil,
              type: 'no' }
          end

          it { expect(subject).to eq("must exist") }
        end
      end
    end
  end
end
