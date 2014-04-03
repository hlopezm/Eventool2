class InvitationPolicy < ApplicationPolicy
#  class Scope < Struct.new(:user, :scope)
#    def resolve
#      scope
#    end
#  end
  def new?
    user
  end

  def create?
    user
  end

  def edit?
    @user == @record.user
  end

  def update?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end

  def new_permitted_attrs
    [:sender, :delivered_at, :receiver, :confirmed_at, :attend, :substitute, :notes, :event_id, :user_id, :person_id]
  end

  def edit_permitted_attrs
    [:sender, :delivered_at, :receiver, :confirmed_at, :attend, :substitute, :notes, :event_id, :user_id, :person_id]
  end
end
