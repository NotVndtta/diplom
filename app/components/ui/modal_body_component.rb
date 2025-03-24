# typed: true

module Ui
  class ModalBodyComponent < ApplicationComponent
    def initialize(classes: nil)
      @classes = classes
    end

    def call
      content_tag(:div, content, class: class_names("p-6", @classes))
    end
  end
end
