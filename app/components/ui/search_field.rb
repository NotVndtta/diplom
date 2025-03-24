# typed: true

module Ui
  class SearchField < ApplicationComponent
    extend T::Sig

    sig { void.params(form_object: ActionView::Helpers::FormBuilder, input_html: T::Hash[Symbol, T.untyped]) }
    def initialize(form_object, input_html: {})
      @form_object = T.let(form_object, ActionView::Helpers::FormBuilder)
      @input_html = T.let(input_html, T::Hash[Symbol, T.untyped])
      @input_html[:maxlength] ||= 100
      @input_html[:class] ||= ""
      @input_html[:class] << "search-input"
      @btn_text = "#{inline_svg "icons/search"} #{I18n.t("shared.buttons.search")}".html_safe
    end
  end
end
