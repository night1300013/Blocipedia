module WikisHelper
  def user_is_authorized_for_private_wiki?(wiki)
    !(wiki.private) && (current_user.admin? || (wiki.user == current_user && current_user.premium? ))
  end

  def user_is_authorized_for_public_wiki?(wiki)
    wiki.private && (current_user.admin? || (wiki.user == current_user && current_user.premium? ))
  end
  
  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true
    }

    extensions = {
      space_after_headers: true,
      autolink:           true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      superscript:        true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      strikethrough:      true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    raw markdown.render(text)
  end


end
