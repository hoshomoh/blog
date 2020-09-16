## This has a fairly harmless hack that wraps the img tag in a div to prevent it from being
## wrapped in a paragraph tag instead, which would totally fuck things up layout-wise
## Usage {% twocolumnfigure 'path/to/image' 'caption goes here in quotes' 'path/to/image' 'caption goes here in quotes' %}
#

module Jekyll
  class RenderTwoColumnTags < Liquid::Tag

  	require "shellwords"
    require "kramdown"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end

    def render(context)

      # Gather settings
      site = context.registers[:site]
      converter = site.find_converter_instance(::Jekyll::Converters::Markdown)

      baseurl = context.registers[:site].config['baseurl']
      label1 = Kramdown::Document.new(@text[1],{remove_span_html_tags:true}).to_html # render markdown in caption
      label1 = converter.convert(label1).gsub(/<\/?p[^>]*>/, "").chomp # remove <p> tags from render output
      label2 = Kramdown::Document.new(@text[3],{remove_span_html_tags:true}).to_html # render markdown in caption
      label2 = converter.convert(label2).gsub(/<\/?p[^>]*>/, "").chomp # remove <p> tags from render output

      if @text[0].start_with?('http://', 'https://','//')
        "<div class='row'><figure class='col fullwidth'><img src='#{@text[0]}'/>"+
        "<figcaption class='maincolumn-figure'>#{label1}</figcaption></figure>"+
        "<span class='gap'></span>"+
        "<figure class='col fullwidth'><img src='#{@text[2]}'/>"+
        "<figcaption class='maincolumn-figure'>#{label2}</figcaption></figure></div>"
      else
        "<div class='row'><figure class='col fullwidth'><img src='#{baseurl}/#{@text[0]}'/>"+
        "<figcaption class='maincolumn-figure'>#{label1}</figcaption></figure>"+
        "<span class='gap'></span>"+
        "<figure class='col fullwidth'><img src='#{baseurl}/#{@text[2]}'/>"+
        "<figcaption class='maincolumn-figure'>#{label2}</figcaption></figure></div>"
      end
    end
  end
end

Liquid::Template.register_tag('twocolumnfigure', Jekyll::RenderTwoColumnTags)
