# typed: strict

module Form
  class NumberField < ApplicationForm
    sig { returns(String) }
    def call
      @form_object.number_field(@object_name, {**@input_html, class: ["input-blue", "w-full", @input_html[:class]]})
    end
  end
end
