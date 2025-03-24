# typed: strict

module Form
  class DatetimeFieldGroup < ApplicationForm
    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        input_html: T::Hash[Symbol, T.untyped],
        classes: T.nilable(String),
        label: T.nilable(String),
        label_html: T::Hash[Symbol, T.untyped],
        show_all_errors: T::Boolean
      )
    end
    def initialize(form_object, object_name, input_html: {}, classes: nil, label: nil, label_html: {}, show_all_errors: false)
      super(form_object, object_name, input_html)
      @classes = T.let(classes, T.nilable(String))
      @label = T.let(label, T.nilable(String))
      @label_html = T.let(label_html, T::Hash[Symbol, T.untyped])
      @show_all_errors = T.let(show_all_errors, T::Boolean)
    end

    sig { returns(String) }
    def call
      render(Form::Group.new(classes: @classes, label_position: @label_html[:position], show_all_errors: @show_all_errors, errors:)) do
        concat(render(Form::Label.new(@form_object, @object_name, @label, @label_html))) if @label
        concat(render(Form::DatetimeField.new(@form_object, @object_name, @input_html)))
      end
    end
  end
end
