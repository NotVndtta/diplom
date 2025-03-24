# typed: strict

module Form
  class DurationNumberFieldGroup < NumberFieldGroup
    PercentageParams = T.type_alias { {value: T.nilable(Numeric), color: String} }

    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        input_html: T::Hash[Symbol, T.untyped],
        classes: T.nilable(String),
        label: T.nilable(String),
        label_html: T::Hash[Symbol, T.untyped],
        percentage: T.nilable(PercentageParams)
      )
    end
    def initialize(form_object, object_name, input_html: {}, classes: nil, label: nil, label_html: {}, percentage: nil)
      super

      @classes = T.let("#{classes} number-field-group ", T.nilable(String))
      @label = T.let(label, T.nilable(String))
      @label_html = T.let(label_html, T::Hash[Symbol, T.untyped])
      @percentage = T.let(percentage, T.nilable(PercentageParams))
    end
  end
end
