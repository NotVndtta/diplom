# typed: strict

module Form
  class MultiselectGroup < ApplicationForm
    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        options: T::Array[T.untyped],
        input_html: T::Hash[Symbol, T.untyped],
        classes: T.nilable(String),
        label: T.nilable(String),
        label_html: T::Hash[Symbol, T.untyped],
        select2_options: T::Hash[Symbol, T.untyped],
        show_all_errors: T::Boolean
      )
    end
    def initialize(form_object, object_name, options = [], input_html: {}, classes: nil, label: nil, label_html: {}, select2_options: {}, show_all_errors: false)
      super(form_object, object_name, input_html)
      @options = T.let(options, T::Array[T.untyped])
      @classes = T.let(classes, T.nilable(String))
      @label = T.let(label, T.nilable(String))
      @label_html = T.let(label_html, T::Hash[Symbol, T.untyped])
      @select2_options = T.let(select2_options, T::Hash[Symbol, T.untyped])
      @show_all_errors = T.let(show_all_errors, T::Boolean)
    end

    sig { returns(String) }
    def call
      render(Form::Group.new(id: "#{@form_object.field_id(@object_name)}_group", classes: @classes, label_position: @label_html[:position], show_all_errors: @show_all_errors, errors:)) do
        concat(render(Form::Label.new(@form_object, @object_name, @label, @label_html))) if @label
        concat(render(Form::Multiselect.new(@form_object, @object_name, @input_html, @options, @select2_options)))
      end
    end
  end
end
