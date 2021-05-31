class ParticipantsController < ApplicationController
  def index
    matching_participants = Participant.all

    @list_of_participants = matching_participants.order({ :created_at => :desc })

    render({ :template => "participants/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_participants = Participant.where({ :id => the_id })

    @the_participant = matching_participants.at(0)

    render({ :template => "participants/show.html.erb" })
  end

  def create
    the_participant = Participant.new
    the_participant.event_id = params.fetch("query_event_id")
    the_participant.member_id = params.fetch("query_member_id")
    the_participant.organizer_id = params.fetch("query_organizer_id")

    if the_participant.valid?
      the_participant.save
      redirect_to("/participants", { :notice => "Participant created successfully." })
    else
      redirect_to("/participants", { :notice => "Participant failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_participant = Participant.where({ :id => the_id }).at(0)

    the_participant.event_id = params.fetch("query_event_id")
    the_participant.member_id = params.fetch("query_member_id")
    the_participant.organizer_id = params.fetch("query_organizer_id")

    if the_participant.valid?
      the_participant.save
      redirect_to("/participants/#{the_participant.id}", { :notice => "Participant updated successfully."} )
    else
      redirect_to("/participants/#{the_participant.id}", { :alert => "Participant failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_participant = Participant.where({ :id => the_id }).at(0)

    the_participant.destroy

    redirect_to("/participants", { :notice => "Participant deleted successfully."} )
  end
end
