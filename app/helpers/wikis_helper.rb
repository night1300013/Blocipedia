module WikisHelper
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
