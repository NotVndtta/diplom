module Ui
  class TextAreaComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, placeholder: "", input_class: "")
      @form = form
      @field_name = field_name
      @label = label
      @placeholder = placeholder
      @input_class = input_class
    end

    def call
      content_tag(:div, class: "field px-3") do
        label_tag = tag.label(@label, for: @field_name, class: "block text-sm mb-2 font-medium")
        input = text_area
        error_tag = error_message
        label_tag + input + error_tag
      end
    end

    private

    def text_area
      input_classes = "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 !whitespace-pre-wrap !resize-none"
      input_classes += " #{@input_class}" unless @input_class.empty?

      @form.text_area(@field_name,
        placeholder: @placeholder,
        class: input_classes
      )
    end

    def error
      return nil if @form.object.nil?
      @form.object.errors[@field_name].first
    end

    def error_message
      return unless error.present?
      tag.span error, class: "text-red-500 text-sm"
    end
  end
end
