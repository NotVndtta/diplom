# typed: strict

module Form
  class Checkbox < ApplicationForm
    sig { returns(String) }
    def call
      if @input_html[:readonly]
        @input_html[:disabled] = true
      end
      @form_object.check_box(
        @object_name,
        {
          **@input_html,
          class: [
            @input_html[:class],
            "w-4 h-4 rounded bg-gray-100 border-gray-300 text-blue-600 transition-colors cursor-pointer focus:ring-0 focus:ring-offset-0"
          ]
        }
      )
    end
  end
end
