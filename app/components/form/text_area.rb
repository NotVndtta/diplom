# typed: strict

module Form
  class TextArea < ApplicationForm
    sig { returns(String) }
    def call
      @form_object.text_area(@object_name, {**@input_html, class: ["input-blue", @input_html[:class]]})
    end

    private

    sig { void }
    def before_render
      add_length_validations
    end
  end
end
