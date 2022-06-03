# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  description  :string
#  location     :string
#  name         :string
#  organizer    :string
#  picture      :string
#  time         :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  organizer_id :integer
#
class Event < ApplicationRecord
    belongs_to :organizer, class_name: "User", counter_cache: true
    has_many :participants
end
