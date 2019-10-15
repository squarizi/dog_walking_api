module V1
  class DogsWalkingController < ApplicationController
    before_action :index_filter, only: [:index]
    before_action :set_dog_walking, except: [:index, :create]

    def index
      dogs_walking = case @scope
                     when 'today' then DogWalking.today
                     when 'all' then DogWalking.all
                     end

      paginate json: dogs_walking, per_page: @per_page
    end

    def show
      render json: { duration: @dog_walking.time_walking }, status: :ok
    end

    def create
      @dog_walking = DogWalking.new(dog_walking_params)

      if @dog_walking.save
        render json: @dog_walking, status: :created
      else
        render_error
      end
    end

    def start_walking
      @dog_walking.start_walking! ? render_ok : render_error
    end

    def finish_walking
      @dog_walking.finish_walking! ? render_ok : render_error
    end

    private

    def dog_walking_params
      params.require(:dog_walking).permit(:duration, :schedule, :pets_quantity, :latitude, :longitude)
    end

    def set_dog_walking
      id = params[:id] || params[:dogs_walking_id]

      @dog_walking = DogWalking.find(id)
    end

    def render_ok
      render json: @dog_walking, status: :ok
    end

    def render_error
      render json: @dog_walking.errors.full_messages, status: :unprocessable_entity
    end

    def request_walkings
      case @scope
      when 'today' then DogWalking.today
      when 'all' then DogWalking.all
      end
    end

    def index_filter
      @per_page = params[:page_quantity] || 10
      @scope = params[:scope] || 'all'
    end
  end
end
