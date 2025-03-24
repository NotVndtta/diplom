# typed: strict

module Form
  class DateField < ApplicationForm
    sig { returns(String) }
    def call
      @form_object.date_field(@object_name, {**@input_html, class: ["input-blue", @input_html[:class]]})
    end

    private

    sig { void }
    def before_render
      add_comparison_validations
    end
  end
end
