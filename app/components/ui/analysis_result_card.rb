# typed: true

module Ui
  class AnalysisResultCard < ApplicationComponent
    DEFAULT_INDICATOR = "default-indicator".freeze

    def initialize(analysis_result)
      @analysis_result = analysis_result
      set_threshold_indicator_css
    end

    def set_threshold_indicator_css
      value = @analysis_result.value
      low_threshold = @analysis_result.analysis_type.low_threshold
      high_threshold = @analysis_result.analysis_type.high_threshold

      @low_indicator_css = (low_threshold && value < low_threshold) ? "low-indicator" : DEFAULT_INDICATOR

      @normally_indicator_css = (
        (low_threshold.present? || high_threshold.present?) &&
          value.between?(low_threshold || -Float::INFINITY, high_threshold || Float::INFINITY)
      ) ? "normally-indicator" : DEFAULT_INDICATOR

      @high_indicator_css = (high_threshold && value > high_threshold) ? "high-indicator" : DEFAULT_INDICATOR
    end
  end
end
