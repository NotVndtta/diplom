# typed: true

module Ui
  class FilterCardComponent < ApplicationComponent
    extend T::Sig

    sig { void.params(selected_count: Integer) }
    def initialize(selected_count: 0)
      @selected_count = selected_count
    end
  end
end
