# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  venmo           :string
#  year            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates :email, format: { with: /\A(.+)@chicagobooth.edu\z/, message: "Email invalid"  }
  has_secure_password

  has_many :events, foreign_key: :organizer_id
end
