class User < ApplicationRecord
  has_many :hostedevents, class_name: "Event", foreign_key: "host_id", dependent: :destroy
end
