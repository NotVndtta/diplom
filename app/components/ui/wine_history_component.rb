# typed: strict

module Ui
  class WineHistoryComponent < ApplicationComponent
    extend T::Sig

    sig { void.params(wine_materials: T::Array[WineMaterial], dependence: String, classes: String) }
    def initialize(wine_materials:, dependence:, classes:)
      @wine_materials = T.let(wine_materials, T::Array[WineMaterial])
      @dependence = T.let(dependence, String)
      @classes = T.let(classes, T.nilable(String))
    end
  end
end
