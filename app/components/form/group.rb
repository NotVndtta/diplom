# typed: strict

module Form
  class Group < ApplicationForm
    sig do
      void.params(
        id: T.nilable(String),
        classes: T.nilable(String),
        label_position: T.nilable(Symbol),
        show_all_errors: T::Boolean,
        errors: T::Array[String]
      )
    end
    def initialize(id: nil, classes: nil, label_position: nil, show_all_errors: false, errors: [])
      @id = T.let(id, T.nilable(String))
      @classes = T.let(classes, T.nilable(String))
      @label_position = T.let(label_position || :top_left, Symbol)
      @show_all_errors = T.let(show_all_errors, T::Boolean)
      @errors = T.let(errors, T::Array[String])
    end

    sig { returns(String) }
    def call
      content_tag(:div, id: @id, class: @classes) do
        concat(content_tag(:div, content, class: label_position(@label_position)))

        if @errors.present?
          concat(
            if @show_all_errors
              content_tag(:ul, @errors.map { "<li>#{_1.sub(/\A./, &:upcase)}</li>" }.join.html_safe, class: "text-sm text-red-600 mt-1")
            else
              content_tag(:p, T.must(@errors.first).sub(/\A./, &:upcase), class: "text-sm text-red-600 mt-1")
            end
          )
        end
      end
    end

    private

    sig { params(position: Symbol).returns(String) }
    def label_position(position)
      {
        top_left: "flex flex-col gap-y-2",
        right: "flex flex-row-reverse items-center gap-x-2",
        left: "flex items-center gap-x-2"
      }[position]
    end
  end
end
