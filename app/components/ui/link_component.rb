# typed: true

module Ui
  class LinkComponent < ApplicationComponent
    def initialize(href: nil, classes: nil, reverse: false, turbo: true, target: nil, data: {}, icon: true)
      @href = href
      @classes = classes
      @reverse = reverse
      @turbo = turbo
      @data = data
      @target = target
      @icon = icon
    end
  end
end
