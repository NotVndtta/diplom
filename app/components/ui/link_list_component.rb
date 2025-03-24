# typed: false

module Ui
  class LinkListComponent < ApplicationComponent
    renders_many :links, "LinkComponent"

    def initialize(wrap_count: 1)
      @wrap_count = wrap_count
    end

    def before_render
      @items_in_tooltip = links.drop(@wrap_count)
    end

    class LinkComponent < ApplicationComponent
      def initialize(name:, href:)
        @name = name
        @href = href
      end

      def call
        link_to(@name, @href, class: "text-gray-900 hover:text-gray-700 active:text-gray-600")
      end
    end
  end
end
