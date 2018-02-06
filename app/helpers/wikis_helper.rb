module WikisHelper
  def user_is_authorized_for_private_wiki?(wiki)
    !(wiki.private) && wiki.user == current_user && (current_user.admin? || current_user.premium?)
  end

  def user_is_authorized_for_public_wiki?(wiki)
    wiki.private && wiki.user == current_user && (current_user.admin? || current_user.premium?)
  end
end
