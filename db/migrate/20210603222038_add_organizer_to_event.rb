class AddOrganizerToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :organizer, :string
    add_column :events, :organizer_id, :integer
    add_column :participants, :commitment, :string
  end
end
