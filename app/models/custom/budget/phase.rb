require_dependency Rails.root.join('app', 'models', 'budget', 'phase').to_s

class Budget
  class Phase < ActiveRecord::Base

    validates :presentation_summary_1, length: { maximum: SUMMARY_MAX_LENGTH }
    validates :presentation_summary_2, length: { maximum: SUMMARY_MAX_LENGTH }
    validates :presentation_summary_3, length: { maximum: SUMMARY_MAX_LENGTH }

  end
end
