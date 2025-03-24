# typed: true

module Ui
  class ListWithTooltip < ApplicationComponent
    def initialize(items: [], wrap_count: 1, list_icon: true, classes: "text-nowrap truncate")
      @items = items
      @list_icon = list_icon
      @first_item = items.first(wrap_count).join(", ")
      @items_in_tooltip = items.drop(wrap_count)
      @classes = classes
    end
  end
end
