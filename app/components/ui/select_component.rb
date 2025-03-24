# typed: true

module Ui
  class SelectComponent < ApplicationComponent
    module Position
      ALL = [
        TOP = "top",
        BOTTOM = "bottom"
      ].freeze
    end

    def initialize(id: nil, name: nil, value: nil, placeholder: nil, position: nil, disabled: nil, classes: nil, svg: nil, data: {}, no_results_if: false)
      @id = id
      @name = name
      @value = value
      @placeholder = placeholder
      @position = position
      @disabled = disabled
      @classes = ["select", classes]
      @svg = svg
      @data = data.merge(dropdown_target: "input")
      @no_results_if = no_results_if
    end
  end
end
