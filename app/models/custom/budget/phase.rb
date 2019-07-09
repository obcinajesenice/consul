require_dependency Rails.root.join('app', 'models', 'budget', 'phase').to_s

class Budget
  class Phase < ActiveRecord::Base

    translates :summary, touch: true
    translates :description, touch: true
    translates :presentation_summary_1, touch: true
    translates :presentation_summary_2, touch: true
    translates :presentation_summary_3, touch: true
    include Globalizable

    # validates_translation :summary, presence: true, length: { minimum: 2 }
    # validates_translation :description, presence: true, length: { minimum: 2 }
    # validates_translation :presentation_summary_1, presence: true, length: { minimum: 2 }
    # validates_translation :presentation_summary_2, presence: true, length: { minimum: 2 }
    # validates_translation :presentation_summary_3, presence: true, length: { minimum: 2 }

    validates :presentation_summary_1, length: { maximum: SUMMARY_MAX_LENGTH }
    validates :presentation_summary_2, length: { maximum: SUMMARY_MAX_LENGTH }
    validates :presentation_summary_3, length: { maximum: SUMMARY_MAX_LENGTH }

  end
end
