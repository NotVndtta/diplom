# typed: true

module Ui
  class LabelComponent < ApplicationComponent
    module Color
      ALL = [
        GREEN = "green",
        YELLOW = "yellow",
        ORANGE = "orange",
        RED = "red",
        BLUE = "blue",
        GRAY = "gray"
      ].freeze
    end

    def initialize(color: nil, classes: nil)
      @classes = ["label", color, classes]
    end

    def call
      content_tag(:p, content, class: @classes)
    end
  end
end
