class ActivitiesController < ApplicationController
  def index
    @activity = Activity.all
  end

  def new
  end

  def create
    act = Activity.new
    act.name = params["activity_name"]
    act._type = params["activity_type"]
    act.date = params["date"]
    act.point_value = params["point_value"]
    act.description = params["description"]
    act.num_rsvp = 0
    act.save
    redirect_to('/activities')

  end
end
