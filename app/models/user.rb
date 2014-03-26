class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :comments
  has_many :tasks
  has_many :invitations

  def admin
  	has_role? :admin
  end
  alias_method :admin?, :admin

  def admin= value
  	if value == "0"
      remove_role :admin
    elsif value == "1"
      add_role :admin
    end
  end
end
