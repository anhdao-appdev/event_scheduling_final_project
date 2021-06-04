class ParticipantsController < ApplicationController

  def attendance
    the_id = params.fetch("path_id")
    @the_event = Event.where({:id => the_id}).at(0)

    matching_participants = Participant.where({:event_id => the_id})
    @list_of_participants = matching_participants.order({:commitment => :desc}).order({ :created_at => :desc })

    render({ :template => "participants/event_attendance.html.erb" })
  end

  def user_events
    the_id = @current_user.id

    going_participants = Participant.where({ :member_id => the_id }).where({:commitment => "Going"}).map_relation_to_array(:event_id)
    @going_events = Event.where({ :id => going_participants})
    interested_participants = Participant.where({ :member_id => the_id }).where({:commitment => "Interested"}).map_relation_to_array(:event_id)
    @interested_events = Event.where({ :id => interested_participants})
  
    @organize_events = Event.where({ :organizer_id => the_id})
    render({ :template => "participants/user_events.html.erb" })
  end

  def create
    the_participant = Participant.new
    the_participant.event_id = params.fetch("query_event_id")
    the_participant.organizer_id = params.fetch("query_organizer_id")
    the_participant.member_id = @current_user.id
    the_participant.commitment = params.fetch("query_commitment")

    if the_participant.valid?
      the_participant.save
      if the_participant.commitment == "Going"
        redirect_to("/user_events", { :notice => "You have successfully registered for this event!" })
      else
        redirect_to("/user_events", { :notice => "You have successfully expressed interest for this event!" })
      end
      else
      redirect_to("/user_events", { :notice => "Your event registration failed!" })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_participant = Participant.where({ :id => the_id }).at(0)
    the_participant.commitment = params.fetch("query_commitment")

    if the_participant.valid?
      the_participant.save
      redirect_to("/user_events/#{the_participant.id}", { :notice => "Participant updated successfully."} )
    else
      redirect_to("/user_events/#{the_participant.id}", { :alert => "Participant failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_participant = Participant.where({ :id => the_id }).at(0)

    the_participant.destroy

    redirect_to("/user_events", { :notice => "Participant deleted successfully."} )
  end
end