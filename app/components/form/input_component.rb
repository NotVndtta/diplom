module Form
  class InputComponent < ViewComponent::Base
    def initialize(form:, field:, type: :text, label: nil, placeholder: nil, min: nil, options: {})
      @form = form
      @field = field
      @type = type
      @label = label
      @placeholder = placeholder
      @min = min
      @options = options
    end

    private

    def input_classes
      "block w-full rounded-lg border-gray-300 shadow-sm focus:border-lime-500 focus:ring-lime-500 sm:text-sm"
    end

    def label_classes
      "block text-sm font-medium text-gray-700 mb-1"
    end
  end
end
