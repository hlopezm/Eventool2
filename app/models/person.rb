class Person < ActiveRecord::Base
  has_many :invitations
  has_many :events, through: :invitations
  belongs_to :user
end
