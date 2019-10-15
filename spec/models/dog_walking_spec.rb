require 'rails_helper'

RSpec.describe DogWalking, type: :model do

  subject {
            DogWalking.new(schedule: 1571157571, price: 30.50,
                           duration: :half_hour, latitude: 44.4604788,
                           longitude: -110.8281375, pets_quantity: 4)
          }

  context '#status enum' do
    let(:status) { { "scheduled" => 0, "on_going" => 1, "finished" => 2 } }

    it { expect(described_class.statuses).to eq status }
  end

  context '#duration enum' do
    let(:duration) { { "half_hour" => 30, "hour" => 60 } }

    it { expect(described_class.durations).to eq duration }
  end

  describe '#start_walking' do
    context "when status is scheduled" do

      before { subject.start_walking! }

      it do
        expect(subject.persisted?).to be_truthy
        expect(subject.start_walk).to be_present
        expect(subject.on_going?).to be_truthy
      end
    end

    context "when status is on_going" do
      before { subject.status = :on_going }

      it { expect(subject.start_walking!).to be_falsey }
    end

    context "when status is finished" do
      before { subject.status = :finished }

      it { expect(subject.start_walking!).to be_falsey }
    end
  end

  describe '#finish_walking' do
    context "when status is on_going" do

      before do
        subject.status = :on_going
        subject.finish_walking!
      end

      it do
        expect(subject.persisted?).to be_truthy
        expect(subject.finish_walk).to be_present
        expect(subject.finished?).to be_truthy
      end
    end

    context "when status is scheduled" do
      before { subject.status = :scheduled }

      it { expect(subject.finish_walking!).to be_falsey }
    end

    context "when status is finished" do
      before { subject.status = :finished }

      it { expect(subject.finish_walking!).to be_falsey }
    end
  end

  describe '#time_walking' do
    context 'when status is scheduled' do
      let(:time) { '00:00:00' }

      it { expect(subject.time_walking).to eq time }
    end

    context 'when status is on_going' do
      let(:time) { '00:30:00' }

      before do
        subject.status = :on_going
        subject.start_walk = Time.now - 30.minutes
      end

      it { expect(subject.time_walking).to eq time }
    end

    context 'when status is finished' do
      let(:time) { '00:30:00' }

      before do
        subject.status = :finished
        subject.start_walk = Time.now
        subject.finish_walk = subject.start_walk + 30.minutes
      end

      it { expect(subject.time_walking).to eq time }
    end
  end

  describe '#set_scheduled_at' do
    let(:scheduled_at) { Time.at(1571157571) }

    before { subject.save }

    it { expect(subject.scheduled_at).to eq scheduled_at }
  end

  describe '#calculate_price' do
    it do
      expect(DogWalkingPrice).to receive(:calculate).with(subject.duration, subject.pets_quantity)

      subject.save
    end
  end
end
