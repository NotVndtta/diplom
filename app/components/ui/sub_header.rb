# typed: true

module Ui
  class SubHeader < ApplicationComponent
    def initialize(back_url: false)
      @back_url = back_url
    end
  end
end
