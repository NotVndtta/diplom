# typed: true

module Ui
  class ModalHeaderComponent < ApplicationComponent
    def initialize(title:, modal_id:, close_btn: false)
      @title = title
      @modal_id = modal_id
      @close_btn = close_btn
    end
  end
end
