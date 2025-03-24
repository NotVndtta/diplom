# typed: strict

module Form
  class Label < ApplicationForm
    sig do
      void.params(
        form_object: ActionView::Helpers::FormBuilder,
        object_name: Symbol,
        text: T.nilable(String),
        label_html: T::Hash[Symbol, T.untyped]
      )
    end
    def initialize(form_object, object_name, text = nil, label_html = {})
      @form_object = form_object
      @object_name = object_name
      @text = T.let(text, T.nilable(String))
      @label_html = T.let(label_html, T::Hash[Symbol, T.untyped])
    end

    sig { returns(String) }
    def call
      text = if @text
        @text
      elsif content
        content
      else
        @form_object.label(@object_name) { |builder| builder.translation }
      end

      if required_field?
        text = "#{text} <abbr class='text-red-600'>*</abbr>".html_safe
      end

      @form_object.label(@object_name, text, **@label_html)
    end

    private

    sig { returns(T::Boolean) }
    def required_field?
      validator = find_validator(ActiveModel::Validations::PresenceValidator)

      required_field = if validator
        if (clause = validator.options[:if])
          case clause
          when Proc
            if clause.arity > 0
              @form_object.object.instance_exec(@form_object.object, &clause)
            else
              @form_object.object.instance_exec(&clause)
            end
          when Symbol, String
            @form_object.object.send(clause)
          else
            fail
          end
        else
          true
        end
      else
        false
      end

      if @label_html[:required].nil?
        required_field
      else
        @label_html[:required]
      end
    end
  end
end
