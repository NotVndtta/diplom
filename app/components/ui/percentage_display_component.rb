# typed: true

module Ui
  class PercentageDisplayComponent < ViewComponent::Base
    def initialize(percentage:, color: "green")
      @percentage = percentage
      @color = color
    end

    def border_color_class
      case @color
      when "green"
        "border-green-400 text-green-500"
      when "blue"
        "border-blue-400 text-blue-500"
      end
    end
  end
end
