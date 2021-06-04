class EventsController < ApplicationController
  
  def calendar
    matching_events = Event.all

    @list_of_events = matching_events.order({ :time => :asc })

    render({ :template => "events/event_calendar.html.erb" })
  end

  def detail
    the_id = params.fetch("path_id")
    matching_events = Event.where({ :id => the_id })
    @the_event = matching_events.at(0)

    matching_participants = Participant.where({:event_id => @the_event.id}).where({:member_id => @current_user.id})
    @the_participant = matching_participants.at(0)

    matching_organizers = Event.where({:id => @the_event.id}).where({:organizer_id => @current_user.id})
    @the_organizer = matching_organizers.at(0)

    render({ :template => "events/event_detail.html.erb" })
  end

  def new_event_form
    render({ :template => "events/event_new_form.html.erb" })
  end

  def create
    the_event = Event.new
    the_event.time = params.fetch("query_time")
    the_event.location = params.fetch("query_location")
    the_event.picture = params.fetch("query_picture")
    the_event.description = params.fetch("query_description")
    the_event.name = params.fetch("query_name")
    the_event.organizer_id = params.fetch("query_organizer_id")
    the_event.organizer = params.fetch("query_organizer")

    if the_event.valid? && the_event.time!=nil
      the_event.save
      redirect_to("/events", { :notice => "Event created successfully." })
    elsif the_event.valid? && the_event.time==nil
      flash[:notice] = "Please enter a valid time for your event."
      redirect_to("/events")
    else
      redirect_to("/events", { :notice => "Event failed to create successfully." })
    end
  end

  def edit_form
    the_id = params.fetch("path_id")
    @the_event = Event.where({ :id => the_id }).at(0)
    
    render({ :template => "events/event_edit_form.html.erb" })
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
