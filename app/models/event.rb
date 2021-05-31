# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  description :string
#  location    :string
#  name        :string
#  picture     :string
#  time        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
end
