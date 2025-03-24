# typed: true

module Ui
  class AddElementBtn < ApplicationComponent
    module Color
      ALL = [
        GREEN = "green",
        BLUE = "blue"
      ].freeze
    end

    def initialize(color:, options: {})
      @color = color
      @options = options
    end

    def call
      content_tag(
        :button,
        inline_svg("icons/plus", class: "mr-2") + "<span class='truncate'>#{content}</span>".html_safe,
        {
          **@options,
          type: @options[:type] || :submit,
          class: ["add-element-btn", @color, @options[:class]]
        }
      )
    end
  end
end
