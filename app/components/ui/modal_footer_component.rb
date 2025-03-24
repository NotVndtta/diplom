# typed: true

module Ui
  class ModalFooterComponent < ApplicationComponent
    def initialize(modal_id:, classes: nil)
      @modal_id = modal_id
      @classes = classes
    end
  end
end
