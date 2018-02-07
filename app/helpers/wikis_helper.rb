module WikisHelper
  def user_is_authorized_for_private_wiki?(wiki)
    !(wiki.private) && (current_user.admin? || (wiki.user == current_user && current_user.premium? ))
  end

  def user_is_authorized_for_public_wiki?(wiki)
    wiki.private && (current_user.admin? || (wiki.user == current_user && current_user.premium? ))
  end
end
