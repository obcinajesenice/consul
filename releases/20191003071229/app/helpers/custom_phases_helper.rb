module CustomPhasesHelper

  CUSTOM_PHASE_ACCEPTING = :accepting
  CUSTOM_PHASE_SELECTING = :selecting
  CUSTOM_PHASE_BALLOTING = :balloting
  CUSTOM_PHASE_FINISHED = :finished
  ATTRIBUTES_TO_UPDATE = [:summary, :presentation_summary_1, :presentation_summary_2, :presentation_summary_3, :description, :starts_at, :ends_at]

  CustomPhase = Struct.new(:kind, :summary, :presentation_summary_1, :presentation_summary_2, :presentation_summary_3, :description, :starts_at, :ends_at, :url, :enabled) do

  end

  def load_custom_phases
    @custom_phases = custom_phases
  end

  def custom_phases
    custom_phases = {}
    if current_budget&.phases
      custom_phases = init_custom_phases
      custom_phases = custom_phases_descriptions(custom_phases)
      custom_phases = custom_phases_links(custom_phases)
    end
    custom_phases
  end

  def init_custom_phases
    custom_phases = {}
    {
      CUSTOM_PHASE_ACCEPTING => true,
      CUSTOM_PHASE_SELECTING => current_budget.phases.selecting.enabled?,
      CUSTOM_PHASE_BALLOTING => true,
      CUSTOM_PHASE_FINISHED => true,
    }.each do |phase, enabled|
      custom_phases[phase] = CustomPhase.new(phase, '', '', '', '', '', nil, nil, nil, enabled)
    end
    custom_phases
  end

  def custom_phases_descriptions(custom_phases)
    ATTRIBUTES_TO_UPDATE.each do |attribute|
      custom_phases[CUSTOM_PHASE_ACCEPTING][attribute] = current_budget.phases.accepting[attribute]
      custom_phases[CUSTOM_PHASE_SELECTING][attribute] = current_budget.phases.selecting[attribute]
      custom_phases[CUSTOM_PHASE_BALLOTING][attribute] = current_budget.phases.balloting[attribute]
      custom_phases[CUSTOM_PHASE_FINISHED][attribute] = current_budget.phases.finished[attribute]
    end
    custom_phases
  end

  def custom_phases_links(custom_phases)
    current_phase = current_budget.phase
    if current_phase === 'accepting' || current_phase === 'reviewing'
      custom_phases[CUSTOM_PHASE_ACCEPTING].url = budget_investments_url(current_budget)
    elsif current_phase === 'selecting' || current_phase === 'valuating' || current_phase === 'publishing_prices'
      if custom_phases[CUSTOM_PHASE_SELECTING].enabled
        custom_phases[CUSTOM_PHASE_SELECTING].url = budget_investments_url(current_budget)
      else
        custom_phases[CUSTOM_PHASE_ACCEPTING].url = budget_investments_url(current_budget)
      end
    elsif current_phase === 'balloting'
      custom_phases[CUSTOM_PHASE_BALLOTING].url = budget_investments_url(current_budget, heading_id: current_budget.headings.first.id)
    elsif current_phase === 'reviewing_ballots'
      custom_phases[CUSTOM_PHASE_BALLOTING].url = budget_investments_url(current_budget)
    elsif current_phase === 'finished'
      custom_phases[CUSTOM_PHASE_FINISHED].url = budget_investments_url(current_budget)
    end
    custom_phases
  end
end
