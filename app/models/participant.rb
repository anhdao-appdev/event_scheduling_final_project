# == Schema Information
#
# Table name: participants
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  event_id     :integer
#  member_id    :integer
#  organizer_id :integer
#
class Participant < ApplicationRecord
end
