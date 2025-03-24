# typed: true

module Ui
  class BtnLink < ApplicationComponent
    def initialize(color:, href: nil, svg: nil, classes: nil, disabled: false, data: {}, content_classes: nil)
      @href = href
      @svg = svg
      @classes = ["btn-#{color} disabled:cursor-not-allowed disabled:opacity-50", classes]
      @disabled = disabled
      @data = data
      @content_classes = content_classes
    end

    def call
      link_to @href, class: @classes, data: @data, disabled: @disabled do
        concat(inline_svg("icons/#{@svg}")) if @svg
        concat(content_tag(:span, content, class: @content_classes)) if content
      end
    end
  end
end
