# app/components/ui/string_input_component.rb
module Ui
  class StringInputComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, placeholder: "", input_class: "", type: "text", autocomplete: nil)
      @form = form
      @field_name = field_name
      @label = label
      @placeholder = placeholder
      @input_class = input_class
      @type = type
      @autocomplete = autocomplete
    end

    def call
      content_tag(:div, class: "field px-3") do
        label_tag = tag.label(@label, for: @field_name, class: "block text-sm mb-2 font-medium text-gray-700")
        input = input_field
        error_tag = error_message
        label_tag + input + error_tag
      end
    end

    private

    def input_field
      input_classes = "bg-white border text-gray-900 text-sm rounded-lg focus:ring-lime-500 focus:border-lime-500 w-full p-2.5 placeholder-gray-400 mt-1 px-3 py-2 border-gray-300 rounded-md shadow-sm focus:outline-none"
      input_classes += " #{@input_class}" unless @input_class.empty?
      input_classes += " !border-red-500" if error.present?

      method = case @type
      when "password" then :password_field
      when "email" then :email_field
      else :text_field
      end

      @form.send(method, @field_name,
        placeholder: @placeholder,
        class: input_classes,
        autocomplete: @autocomplete
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
  end
end
