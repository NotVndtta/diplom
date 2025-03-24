# typed: true

module Ui
  class Pagination < ApplicationComponent
    def initialize(view_model:)
      @view_model = view_model
    end
  end
end
