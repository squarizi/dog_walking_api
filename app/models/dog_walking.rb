class DogWalking < ActiveRecord::Base

  attr_accessor :schedule

  enum status: { scheduled: 0, on_going: 1, finished: 2 }

  enum duration: { half_hour: 30, hour: 60 }

  validates :duration, :latitude, :longitude, :pets_quantity, presence: true

  before_create :parse_scheduled_at, :calculate_price

  scope :today, -> { where(scheduled_at: Time.now..Time.now.end_of_day) }

  def start_walking!
    return false unless scheduled?

    self.status = :on_going
    self.start_walk = Time.now
    save!
  end

  def finish_walking!
    return false unless on_going?

    self.status = :finished
    self.finish_walk = Time.now
    save!
  end

  def time_walking
    Time.at(time_walking_in_seconds).gmtime.strftime('%R:%S')
  end

  private

  def time_walking_in_seconds
    return 0 if scheduled?
    return Time.now - start_walk if on_going?
    return finish_walk - start_walk if finished?
  end

  def parse_scheduled_at
    self.scheduled_at = Time.at(schedule.to_i)
  end

  def calculate_price
    self.price = DogWalkingPrice.calculate(duration, pets_quantity)
  end
end
