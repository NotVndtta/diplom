module ApplicationHelper
    def status_color_classes(status)
        case status.downcase
        when 'pending' then 'bg-yellow-100 text-yellow-800'
        when 'completed' then 'bg-green-100 text-green-800'
        when 'in_progress' then 'bg-blue-100 text-blue-800'
        when 'cancelled' then 'bg-red-100 text-red-800'
        else 'bg-gray-100 text-gray-800'
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
