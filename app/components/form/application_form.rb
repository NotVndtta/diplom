# typed: strict

module Form
  class ApplicationForm < ApplicationComponent
    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        input_html: T::Hash[Symbol, T.untyped]
      )
    end
    def initialize(form_object, object_name, input_html = {})
      @form_object = T.let(form_object, ActionView::Helpers::FormBuilder)
      @object_name = T.let(object_name, Symbol)
      @input_html = T.let(input_html, T::Hash[Symbol, T.untyped])
    end

    private

    sig { returns(T::Array[String]) }
    def errors
      @form_object.object.errors[@object_name]
    end

    sig { void }
    def add_length_validations
      if (length_validator = find_validator(ActiveModel::Validations::LengthValidator))
        @input_html[:maxlength] = length_validator.options[:maximum]
      end
    end

    sig { void }
    def add_comparison_validations
      if (comparison_validator = find_validator(ActiveModel::Validations::ComparisonValidator))
        comparison_validator.options.each do |key, value|
          if value.is_a?(Proc)
            value = if value.arity == 1
              value.call(@form_object.object)
            else
              value.call
            end
          end

          case key
          when :greater_than_or_equal_to
            @input_html[:min] = value
          when :less_than_or_equal_to
            @input_html[:max] = value
          end
        end
      end
    end

    sig { params(validator_class: T.class_of(ActiveModel::Validator)).returns(T.nilable(ActiveModel::Validator)) }
    def find_validator(validator_class)
      @form_object.object.class.validators_on(@object_name).find { _1.instance_of?(validator_class) }
    end
  end
end
