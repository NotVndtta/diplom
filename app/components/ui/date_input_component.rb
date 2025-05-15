module Ui
  class DateInputComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, input_class: "")
      @form = form
      @field_name = field_name
      @label = label
      @input_class = input_class
      @min_date = Date.current.to_s
    end
  end
end
