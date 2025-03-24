# typed: true

module Ui
  class ModalComponent < ApplicationComponent
    def initialize(modal_id: "modal", js_controller: "remote-modal")
      @modal_id = modal_id
      @js_controller = js_controller
    end
  end
end
