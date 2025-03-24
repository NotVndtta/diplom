# typed: true

module Ui
  class Badge < ApplicationComponent
    def initialize(icon:, classes: nil)
      @icon = icon
      @classes = classes
    end
  end
end
