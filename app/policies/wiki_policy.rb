class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis, or that private wikis they created or admin makes it private, and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
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
