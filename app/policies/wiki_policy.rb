class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      wikis = []
      if user.nil? || user.standard?
        scope.where(private: false)
      else
        scope.all
      end
    end

    def show_my_wikis
      if user.nil?
      else
        scope.where(user: user)
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
