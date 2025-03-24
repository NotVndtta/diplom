# typed: true

module Ui
  class DateFormatter < ApplicationComponent
    def initialize(date)
      @date = date
    end

    def call
      month_name = @date.strftime("%B").downcase
      "#{@date.day} #{I18n.t("date.abbr_month_names.#{month_name}")} #{@date.year}".html_safe
    end
  end
end
