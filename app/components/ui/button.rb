# typed: true

module Ui
  class Button < ApplicationComponent
    def initialize(color:, id: nil, type: "button", svg: nil, classes: nil, disabled: false, data: {}, content_classes: nil)
      @id = id
      @type = type
      @svg = svg
      @classes = ["btn-#{color} disabled:cursor-not-allowed disabled:opacity-50", classes]
      @disabled = disabled
      @data = data
      @content_classes = content_classes
    end

    def call
      content_tag(:button, type: @type, id: @id, class: @classes, disabled: @disabled, data: @data) do
        concat(inline_svg("icons/#{@svg}")) if @svg
        concat(content_tag(:span, content, class: @content_classes)) if content
      end
    end
  end
end
