# typed: strict

module Ui
  class FormGroupComponent < ApplicationComponent
    extend T::Sig

    sig do
      void.params(
        classes: T.nilable(String),
        input_classes: T.nilable(String),
        data: T::Hash[Symbol, T.untyped],
        caption_data: T::Hash[Symbol, T.untyped],
        errors: T::Array[ActiveModel::Errors],
        label_position: T.nilable(String)
      )
    end
    def initialize(classes: nil, input_classes: nil, data: {}, caption_data: {}, errors: [], label_position: "top")
      @classes = T.let(["flex flex-col space-y-1", classes], T::Array[T.nilable(String)])
      @input_classes = T.let([label_position_classes(label_position), input_classes, ("errors" if errors.present?)], T::Array[T.untyped])
      @caption_classes = T.let([("text-red-600" if errors.present?)], T::Array[T.nilable(String)])
      @data = T.let(data, T::Hash[Symbol, T.untyped])
      @caption_data = T.let(caption_data, T::Hash[Symbol, T.untyped])
      @errors = T.let(errors, T::Array[ActiveModel::Errors])
    end

    private

    sig { returns(String).params(position: T.nilable(String)) }
    def label_position_classes(position)
      case position
      when "top"
        "flex flex-col space-y-2"
      when "right"
        "flex flex-row-reverse space-x-2 items-center"
      when "bottom"
        "flex flex-col-reverse space-y-2"
      when "left"
        "flex space-x-2 items-center"
      else
        "flex flex-col space-y-2"
      end
    end
  end
end
