module ApplicationHelper
    def status_color_classes(status)
        return "bg-gray-100 text-gray-800" if status.nil?

        case status.to_s.downcase
        when "active" then "bg-lime-100 text-lime-800"
        when "archived" then "bg-gray-100 text-gray-600"
        else "bg-gray-100 text-gray-800"
        end
    end

    def base_input_class(object, field)
      base = "block w-full rounded-md shadow-sm px-3 py-2 border focus:outline-none transition"
      if object.errors[field].any?
        "#{base} border-red-400 focus:ring-red-500 focus:border-red-500"
      else
        "#{base} border-gray-300 focus:ring-indigo-500 focus:border-indigo-500"
      end
    end

    def required_field?(model, attribute)
      return false unless model.respond_to?(:class)
      model.class.validators_on(attribute).any? do |validator|
        validator.kind == :presence && validator.options[:if].blank? && validator.options[:unless].blank?
      end
    end
end
