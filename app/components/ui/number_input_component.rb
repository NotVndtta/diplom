# typed: true

module Ui
  class NumberInputComponent < ApplicationComponent
    def initialize(id: nil, name: nil, value: nil, placeholder: nil, required: false, disabled: false,
      classes: nil, step: nil, min: nil, max: nil, **options)
      @id = id
      @name = name
      @value = value
      @placeholder = placeholder
      @required = required
      @disabled = disabled
      @classes = ["number-input", classes]
      @step = step
      @min = min
      @max = max
      @options = options
    end

    def call
      content_tag(
        :input,
        nil,
        type: "number",
        id: @id,
        name: @name,
        value: @value,
        placeholder: @placeholder,
        class: @classes,
        step: @step,
        min: @min,
        max: @max,
        disabled: @disabled,
        required: @required,
        **@options
      )
    end
  end
end
