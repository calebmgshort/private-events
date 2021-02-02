class Event < ApplicationRecord
  belongs_to :host, class_name: "User", foreign_key: "host_id"
  has_and_belongs_to_many :attendees, class_name: "User", foreign_key: "event_id", association_foreign_key: "attendee_id", join_table: "attendees_events"

  def self.past
    Event.all.where("date < ?", Date.today)
  end

  def self.upcoming
    Event.all.where("date >= ?", Date.today)
  end
end
