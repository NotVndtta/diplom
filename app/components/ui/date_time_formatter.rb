# typed: true

module Ui
  class DateTimeFormatter < ApplicationComponent
    def initialize(date)
      @date = date
    end

    def call
      month_name = @date.strftime("%B").downcase
      hour = @date.strftime("%H").downcase
      min = @date.strftime("%M").downcase
      "#{@date.day} #{I18n.t("date.abbr_month_names.#{month_name}")} #{@date.year}, #{hour}:#{min}".html_safe
    end
  end
end
