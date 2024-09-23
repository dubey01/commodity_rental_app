# frozen_string_literal: true

module ListingStrategies
  # class for calling and managing various strategies
  class Manager
    STRATEGIES = { 1 => HighestMonthlyPrice, 2 => HighestOverallPrice }.freeze

    def call(strategy_key, params)
      STRATEGIES[strategy_key].new.execute(params.with_indifferent_access)
    end
  end
end
