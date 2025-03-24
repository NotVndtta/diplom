# typed: strict

module Form
  class DatetimeField < ApplicationForm
    sig { returns(String) }
    def call
      @form_object.datetime_field(@object_name, {**@input_html, include_seconds: false, class: ["input-blue", @input_html[:class]]})
    end
  end
end
