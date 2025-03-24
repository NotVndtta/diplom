# typed: true

module Ui
  class OperationStatusComponent < ApplicationComponent
    def initialize(status:)
      @status = status
    end
  end
end
