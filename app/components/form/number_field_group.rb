# typed: strict

module Form
  class NumberFieldGroup < ApplicationForm
    PercentageParams = T.type_alias { {value: T.nilable(Numeric), color: String} }

    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        input_html: T::Hash[Symbol, T.untyped],
        classes: T.nilable(String),
        label: T.nilable(String),
        label_html: T::Hash[Symbol, T.untyped],
        percentage: T.nilable(PercentageParams),
        show_all_errors: T::Boolean
      )
    end
    def initialize(form_object, object_name, input_html: {}, classes: nil, label: nil, label_html: {}, percentage: nil, show_all_errors: false)
      super(form_object, object_name, input_html)
      @classes = T.let("#{classes} number-field-group", T.nilable(String))
      @label = T.let(label, T.nilable(String))
      @label_html = T.let(label_html, T::Hash[Symbol, T.untyped])
      @percentage = T.let(percentage, T.nilable(PercentageParams))
      @show_all_errors = T.let(show_all_errors, T::Boolean)
    end

    sig { returns(T::Boolean) }
    def has_percentage?
      @percentage.present?
    end

    sig { returns(Float) }
    def percentage_value
      percentage = @percentage

      if percentage && (value = percentage[:value])
        value
      else
        0.0
      end
    end

    sig { returns(String) }
    def percentage_color
      percentage = @percentage

      if percentage && (color = percentage[:color])
        color
      else
        "none"
      end
    end
  end
end
