class AddBudgetPhaseTranslations < ActiveRecord::Migration

  def self.up
    Budget::Phase.create_translation_table!(
      {
        summary:                :string,
        description:            :string,
        presentation_summary_1: :string,
        presentation_summary_2: :string,
        presentation_summary_3: :string,
      },
      { migrate_data: true }
    )
  end

  def self.down
    Budget::Phase.drop_translation_table!
  end
end
