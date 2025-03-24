# typed: true

module Ui
  class Spinner < ApplicationComponent
    def call
      "<div class='flex items-center gap-2'>#{inline_svg("icons/spinner")} #{t("views.loading")}</div>".html_safe
    end
  end
end
