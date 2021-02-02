class LinkAttendeesAndEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :attendees_events, id: false  do |t|
      t.bigint :attendee_id
      t.bigint :event_id
    end

    add_index :attendees_events, :attendee_id
    add_index :attendees_events, :event_id
  end
end
