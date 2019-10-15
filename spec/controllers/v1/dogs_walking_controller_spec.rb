require 'rails_helper'

describe V1::DogsWalkingController, type: :controller do

  subject {
            DogWalking.new(schedule: 1571157571, price: 30.50,
                           duration: :half_hour, latitude: 44.4604788,
                           longitude: -110.8281375, pets_quantity: 4)
          }

  context '#create' do
    context 'when params is ok' do
      let(:params) { {
                      dog_walking: {
                                      duration: :half_hour,
                                      schedule: 1571157571,
                                      pets_quantity: 2,
                                      latitude: 123,
                                      longitude: 321
                                   }
                   } }

      before { post :create, params: params }

      it { expect(response).to have_http_status(:created) }
    end
  end

  context '#show' do
    context 'when dog walking status is scheduled' do
      let(:body) { { duration: '00:00:00' } }

      before do
        subject.save
        get :show, params: { id: subject.id }
      end

      it { expect(response.body).to eq body.to_json }
    end

    context 'when dog walking status is on_going' do
      let(:body) { { duration: '00:30:00' } }

      before do
        subject.status = :on_going
        subject.start_walk = Time.now - 30.minutes
        subject.save
        get :show, params: { id: subject.id }
      end

      it { expect(response.body).to eq body.to_json }
    end

    context 'when dog walking status is finished' do
      let(:body) { { duration: '00:30:00' } }

      before do
        subject.status = :finished
        subject.start_walk = Time.now
        subject.finish_walk = subject.start_walk + 30.minutes
        subject.save
        get :show, params: { id: subject.id }
      end

      it { expect(response.body).to eq body.to_json }
    end
  end

  context '#start_walking' do
    before do
      subject.save
      put :start_walking, params: { dogs_walking_id: subject.id }
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#finish_walking' do
    before do
      subject.status = :on_going
      subject.save
      put :finish_walking, params: { dogs_walking_id: subject.id }
    end

    it { expect(response).to have_http_status(:ok) }
  end
end
