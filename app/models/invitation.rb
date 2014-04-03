class Invitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :person

  scope :for_today, ->() {
    where(["DATE(start_at) <= DATE(?) AND DATE(?) <= DATE(end_at)", Date.today, Date.today])
  }
end
