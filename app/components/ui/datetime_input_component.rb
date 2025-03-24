# typed: true

module Ui
  class DatetimeInputComponent < ApplicationComponent
    DATETIME_INPUT_FORMAT = "%Y-%m-%dT%H:%M"

    def initialize(id: nil, name: nil, value: nil, placeholder: nil, required: false, disabled: false,
      classes: nil, data: {})
      @id = id
      @name = name

      raw_value = value || Time.current
      @value = case raw_value
      when String
        Time.zone.parse(raw_value).strftime(DATETIME_INPUT_FORMAT)
      when Time, DateTime, Date, ActiveSupport::TimeWithZone
        raw_value.strftime(DATETIME_INPUT_FORMAT)
      when NilClass
        nil
      else
        raise("bad value input")
      end

      @placeholder = placeholder
      @required = required
      @disabled = disabled
      @classes = ["datetime-input", classes]
      @data = data
    end

    def call
      content_tag(
        :input,
        nil,
        type: "datetime-local",
        name: @name,
        value: @value,
        placeholder: @placeholder,
        class: @classes,
        disabled: @disabled,
        required: @required,
        data: @data
      )
    end
  end
end
