# typed: true

module Ui
  class FormLabelComponent < ApplicationComponent
    def initialize(html_for: nil, required: false, classes: nil)
      @for = html_for
      @required = required
      @classes = classes
    end

    def call
      content_tag(:label, for: @for, class: @classes) do
        concat(content)
        concat("<abbr class='text-red-600'> *</abbr>".html_safe) if @required
      end
    end
  end
end
