class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil? || user.standard?
        scope.where(private: false)
      else
        scope.all
      end
    end
  end

  def update?
    user.present?
  end

  def destroy?
    user.admin? || user == record.user
  end

  def public?
    user.admin? || user.premium?
  end

  def private?
    user.admin? || user.premium?
  end
end
