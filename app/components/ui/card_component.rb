# typed: true

module Ui
  class CardComponent < ApplicationComponent
    module Color
      ALL = [
        BLUE = "blue",
        GREEN = "green"
      ].freeze
    end

    def initialize(color: nil, classes: nil, **options)
      @classes = ["card", color, classes]
      @options = options
    end

    def call
      content_tag(:div, content, class: @classes, **@options)
    end
  end
end
