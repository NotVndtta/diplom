# typed: true

module Ui
  class TextInputComponent < ApplicationComponent
    def initialize(id: nil, name: nil, value: nil, classes: nil, placeholder: nil, maxlength: nil, required: false, disabled: false, **options)
      @id = id
      @name = name
      @value = value
      @classes = ["py-3 px-4 text-sm sm:text-base border border-gray-200 rounded-lg bg-gray-50 hover:border-blue-600 focus:ring-0 focus:border-blue-600", classes]
      @placeholder = placeholder
      @maxlength = maxlength
      @required = required
      @disabled = disabled
      @options = options
    end

    def call
      content_tag(
        :input,
        nil,
        type: "text",
        id: @id,
        name: @name,
        value: @value,
        class: @classes,
        placeholder: @placeholder,
        maxlength: @maxlength,
        required: @required,
        disabled: @disabled,
        **@options
      )
    end
  end
end
