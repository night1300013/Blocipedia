module CollaboratorHelper
  def all_user_except_current_user 
    User.all_except(current_user)
  end
end
