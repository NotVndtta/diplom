# typed: strict

module Form
  class Multiselect < ApplicationForm
    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        input_html: T::Hash[Symbol, T.untyped],
        options: T::Array[T.untyped],
        select2_options: T::Hash[Symbol, T.untyped]
      )
    end
    def initialize(form_object, object_name, input_html = {}, options = [], select2_options = {})
      super(form_object, object_name, input_html)
      @options = T.let(options, T::Array[T.untyped])
      @select2_options = T.let(select2_options, T::Hash[Symbol, T.untyped])
    end

    SELECT2_OPTIONS = [
      "allowClear",
      "search"
    ]

    sig { returns(String) }
    def call
      controllers = ["select2"]
      controllers << "form-submitter" if @input_html.dig(:data, :target_name)

      @input_html[:disabled] = @input_html.delete(:readonly) if @input_html[:readonly]

      @form_object.select(
        @object_name,
        @options,
        {},
        {
          **@input_html,
          multiple: true,
          class: [*@input_html[:class]],
          "data-controller": controllers.join(" "),
          "data-select2-mode-value": "multiple",
          "data-select2-placeholder-value": @input_html[:placeholder]
        }.merge(
          SELECT2_OPTIONS.map { |key| ["data-select2-#{key.underscore.tr("_", "-")}-value", @select2_options[key.to_sym]] }.to_h
        )
      )
    end
  end
end
