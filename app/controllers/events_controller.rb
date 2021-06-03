class EventsController < ApplicationController
  def index
    matching_events = Event.all

    @list_of_events = matching_events.order({ :time => :desc })

    render({ :template => "events/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_events = Event.where({ :id => the_id })

    @the_event = matching_events.at(0)

    render({ :template => "events/show.html.erb" })
  end

  def create
    the_event = Event.new
    the_event.time = params.fetch("query_time")
    the_event.location = params.fetch("query_location")
    the_event.picture = params.fetch("query_picture")
    the_event.description = params.fetch("query_description")
    the_event.name = params.fetch("query_name")

    if the_event.valid?
      the_event.save
      redirect_to("/events", { :notice => "Event created successfully." })
    else
      redirect_to("/events", { :notice => "Event failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_event = Event.where({ :id => the_id }).at(0)

    the_event.time = params.fetch("query_time")
    the_event.location = params.fetch("query_location")
    the_event.picture = params.fetch("query_picture")
    the_event.description = params.fetch("query_description")
    the_event.name = params.fetch("query_name")

    if the_event.valid?
      the_event.save
      redirect_to("/events/#{the_event.id}", { :notice => "Event updated successfully."} )
    else
      redirect_to("/events/#{the_event.id}", { :alert => "Event failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_event = Event.where({ :id => the_id }).at(0)

    the_event.destroy

    redirect_to("/events", { :notice => "Event deleted successfully."} )
  end
end
