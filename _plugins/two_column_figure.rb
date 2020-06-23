## This has a fairly harmless hack that wraps the img tag in a div to prevent it from being
## wrapped in a paragraph tag instead, which would totally fuck things up layout-wise
## Usage {% twocolumnfigure 'path/to/image' 'caption goes here in quotes' 'path/to/image' 'caption goes here in quotes' %}
#
module Jekyll
  class RenderFullWidthTag < Liquid::Tag

    require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end

    def render(context)
      baseurl = context.registers[:site].config['baseurl']
      "<div class='row'><figure class='col fullwidth'><img src='#{baseurl}/#{@text[0]}'/>"+
      "<figcaption>#{@text[1]}</figcaption></figure>"+
      "<span class='gap'></span>"+
      "<figure class='col fullwidth'><img src='#{baseurl}/#{@text[2]}'/>"+
      "<figcaption>#{@text[3]}</figcaption></figure></div>"
    end
  end
end

Liquid::Template.register_tag('twocolumnfigure', Jekyll::RenderFullWidthTag)
