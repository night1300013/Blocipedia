class WikiPolicy < ApplicationPolicy
#  attr_reader :user, :wiki

  def update?
    user.present?
  end

  def destroy?
    user.admin? || user == record.user
  end
end
