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
      content_tag(:div, class: "field") do
        label_tag = tag.label(class: "block text-sm mb-2 font-medium text-gray-700") do
          safe_join([ @label, required_marker ], " ")
        end
        input = text_area
        error_tag = error_message
        label_tag + input + error_tag
      end
    end

    private

    def text_area
      input_classes = "bg-white border text-gray-900 text-sm rounded-lg focus:ring-2 focus:ring-lime-500 focus:border-lime-500 w-full placeholder-gray-400 mt-1 px-3 py-2 border-gray-300 rounded-md shadow-sm focus:outline-none"
      input_classes += " #{@input_class}" unless @input_class.empty?
      input_classes += " !border-red-500" if error.present?

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
      tag.span error, class: "text-red-500 text-sm block"
    end

    def required_marker
      return unless required_field?
      tag.span("*", class: "text-red-500")
    end

    def required_field?
      return false unless @form.object
      validators = @form.object.class.validators_on(@field_name)
      validators.any? do |validator|
        validator.kind == :presence &&
        validator.options[:if].blank? &&
        validator.options[:unless].blank?
      end
    end
  end
end
