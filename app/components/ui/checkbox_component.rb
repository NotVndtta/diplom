# typed: true

module Ui
  class CheckboxComponent < ApplicationComponent
    def initialize(id: nil, checked: false, readonly: false, value: nil, container_classes: nil, classes: nil, name: nil, data: {})
      @id = id
      @container_classes = container_classes
      @checked = checked
      @readonly = readonly
      @value = value
      @name = name
      @data = data
    end

    def call
      content_tag(:div, class: [@container_classes, "flex items-center space-x-2"]) do
        concat(
          content_tag(
            :input,
            nil,
            id: @id,
            type: "checkbox",
            data: @data,
            name: @name,
            value: @value,
            checked: @checked,
            disabled: @readonly,
            class: "w-4 h-4 rounded bg-gray-100 border-gray-300 text-blue-600 transition-colors cursor-pointer focus:ring-0 focus:ring-offset-0"
          )
        )
        concat(content_tag(:label, content, for: @id, class: "cursor-pointer"))
      end
    end
  end
end
