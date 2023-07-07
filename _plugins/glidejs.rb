module Jekyll
  class SliderTag < Liquid::Block
    alias_method :render_block, :render

    def render(context)
      page = context.environments.first['page']
      page['glidejs_active'] = true
      # generate slider id
      slider_id = "slider_" + ("a".."z").to_a.shuffle[0,5].join
      # call the default markdown renderer
      site = context.registers[:site]
      converter = 
      if site.respond_to?(:find_converter_instance)
        site.find_converter_instance(Jekyll::Converters::Markdown)
      else
        site.getConverterImpl(Jekyll::Converters::Markdown)
      end
      # render the markdown, then remove all <p></p> tags from the html
      output = converter.convert(render_block(context)).gsub(/<\/?p>/, '')

      # # wrap <img> into <li>
      output = output.gsub(">", "></li>")
      output = output.gsub("<img", "<li class=\"glide__slide\"><img")

      # render the slider body
      slider_body = "<div id=\"#{slider_id}\" class=\"glide\">"
      slider_body += "<div class=\"glide__track\" data-glide-el=\"track\">"
      slider_body += "<ul class=\"glide__slides\">"
      slider_body += output
      slider_body += "</ul>"
      slider_body += "</div>"
      slider_body += "<div class=\"glide__arrows\" data-glide-el=\"controls\">"
      slider_body += "<button class=\"glide__arrow glide__arrow--left\" data-glide-dir=\"<\">←</button>"
      slider_body += "<button class=\"glide__arrow glide__arrow--right\" data-glide-dir=\">\">→</button>"
      slider_body += "</div>"
      slider_body += "</div>"

      # render the slider script
      slider_script = "<script>"
      slider_script += "new Glide(\'.glide\', {"
      slider_script += "type: \'carousel\',"
      slider_script += "}).mount()"
      slider_script += "</script>"

      slider_body + slider_script
    end
  end
end

Liquid::Template.register_tag('slider', Jekyll::SliderTag)
