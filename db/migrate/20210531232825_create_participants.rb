class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.integer :event_id
      t.integer :member_id
      t.integer :organizer_id

      t.timestamps
    end
  end
end
