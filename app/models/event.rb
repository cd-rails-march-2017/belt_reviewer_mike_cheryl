class Event < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :users, through: 'Event_Attendees'
  has_many :comments
end
