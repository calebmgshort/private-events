class User < ApplicationRecord
  has_many :hostedevents, class_name: "Event", foreign_key: "host_id", dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: "Event", foreign_key: "attendee_id", association_foreign_key: "event_id", join_table: "attendees_events"
end
