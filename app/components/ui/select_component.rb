module Ui
  class SelectComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, options:, input_class: "")
      @form = form
      @field_name = field_name
      @label = label
      @options = options
      @input_class = input_class
    end
  end
end
