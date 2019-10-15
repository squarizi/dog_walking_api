require 'rails_helper'

RSpec.describe DogWalkingPrice do

  describe '#contants' do
    let(:initial_price) { { half_hour: 25, hour: 35 } }
    let(:additional_price) { { half_hour: 15, hour: 20 } }

    it { expect(described_class::INITIAL_PRICE).to eq initial_price }
    it { expect(described_class::ADDITIONAL_PRICE).to eq additional_price }
  end

  describe '#calculate' do
    context 'when duration is half_hour' do
      let(:duration) { 'half_hour' }

      context 'when have no additional_price' do
        let(:pets_quatity) { 1 }
        let(:price) { 25 }

        it { expect(described_class.calculate(duration, pets_quatity)).to eq price }
      end

      context 'when have additional_price' do
        let(:pets_quatity) { 2 }
        let(:price) { 40 }

        it { expect(described_class.calculate(duration, pets_quatity)).to eq price }
      end
    end

    context 'when duration is hour' do
      let(:duration) { 'hour' }

      context 'when have no additional_price' do
        let(:pets_quatity) { 1 }
        let(:price) { 35 }

        it { expect(described_class.calculate(duration, pets_quatity)).to eq price }
      end

      context 'when have additional_price' do
        let(:pets_quatity) { 2 }
        let(:price) { 55 }

        it { expect(described_class.calculate(duration, pets_quatity)).to eq price }
      end
    end
  end
end
