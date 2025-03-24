# typed: strict

module Form
  class RadioCollectionGroup < ApplicationForm
    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        options: T::Hash[String, String],
        checked_option: T.nilable(String),
        label: T.nilable(String),
        placeholder: T.nilable(String),
        label_html: T::Hash[Symbol, T.untyped],
        input_html: T::Hash[Symbol, T.untyped]
      )
    end
    def initialize(form_object, object_name, options = {}, checked_option: nil, label: nil, placeholder: nil, label_html: {}, input_html: {})
      @form_object = form_object
      @object_name = object_name
      @options = T.let(options.to_h, T::Hash[String, String])
      @checked_option = T.let(checked_option, T.nilable(String))
      @label = T.let(label, T.nilable(String))
      @label_html = T.let(label_html, T::Hash[Symbol, T.untyped])
      @placeholder = T.let(placeholder, T.nilable(String))
      @input_html = T.let(input_html, T::Hash[Symbol, T.untyped])
    end
  end
end
