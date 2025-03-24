# typed: true

module Ui
  class FileInputComponent < ApplicationComponent
    def initialize(id: nil, name: nil, value: nil, classes: nil, accept: nil, required: false, disabled: false, **options)
      @id = id
      @name = name
      @value = value
      @classes = ["border border-gray-200 rounded-lg bg-gray-50 hover:border-blue-600 focus:ring-0 focus:border-blue-600", classes]
      @accept = accept
      @required = required
      @disabled = disabled
      @options = options
    end

    def call
      content_tag(
        :input,
        nil,
        type: "file",
        id: @id,
        name: @name,
        value: @value,
        class: @classes,
        accept: @accept,
        required: @required,
        disabled: @disabled,
        **@options
      )
    end
  end
end
