# typed: false

module Ui
  class StatusLabel < ApplicationComponent
    erb_template %(
      <p class="flex items-center space-x-1  text-<%= @color %>-500">
        <span class="capitalize"><%= @label %></span>
        <%= icon %>
      </p>
    )

    def initialize(color:, label:, icon:)
      @color = color
      @label = label
      @icon = icon
    end

    def icon
      inline_svg("icons/#{@icon}").html_safe
    end
  end
end
