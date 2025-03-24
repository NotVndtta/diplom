# typed: true

module Ui
  class CaptionComponent < ApplicationComponent
    def initialize(classes: nil, hidden: false, data: {})
      @classes = ["text-sm", classes, ("hidden" if hidden)]
      @data = data
    end

    def call
      content_tag(:p, content, class: @classes, data: @data)
    end
  end
end
