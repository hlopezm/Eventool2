class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :tasks
  has_many :invitations
  has_many :persons, through: :invitations

  validates :name, presence: true, length: { maximum: 60 }
  validates_length_of :description, minimum: 10, allow_blank: true
  validates :user, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  scope :for_today, ->() {
    where(["DATE(start_at) <= DATE(?) AND DATE(?) <= DATE(end_at)", Date.today, Date.today])
  }

  scope :next_week, ->() {
    start = Date.today.next_week
    last = start.end_of_week
    
    where("DATE(start_at) <= ? AND DATE(end_at) >= ?", last, start)
  }

  scope :name_like, lambda { |name|
    where(["name like ?", "%#{name}%"])
  }

  private

  def start_at_is_present
    if start_at.blank?
      errors.add(:start_at, "debes introducir la fecha de inicio")
    end
  end
end
