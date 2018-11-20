module CustomPhasesHelper

  CUSTOM_PHASE_ACCEPTING = :accepting
  CUSTOM_PHASE_SELECTING = :selecting
  CUSTOM_PHASE_BALLOTING = :balloting
  CUSTOM_PHASE_FINISHED = :finished

  CustomPhase = Struct.new(:kind, :summary, :description, :url, :enabled) do

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
      custom_phases[phase] = CustomPhase.new(phase, nil, nil, nil, enabled)
    end
    custom_phases
  end

  def custom_phases_descriptions(custom_phases)
    custom_phases[CUSTOM_PHASE_ACCEPTING].summary = current_budget.phases.accepting.summary
    custom_phases[CUSTOM_PHASE_ACCEPTING].description = current_budget.phases.accepting.description
    custom_phases[CUSTOM_PHASE_SELECTING].summary = current_budget.phases.selecting.summary
    custom_phases[CUSTOM_PHASE_SELECTING].description = current_budget.phases.selecting.description
    custom_phases[CUSTOM_PHASE_BALLOTING].summary = current_budget.phases.balloting.summary
    custom_phases[CUSTOM_PHASE_BALLOTING].description = current_budget.phases.balloting.description
    custom_phases[CUSTOM_PHASE_FINISHED].summary = current_budget.phases.finished.summary
    custom_phases[CUSTOM_PHASE_FINISHED].description = current_budget.phases.finished.description
    custom_phases
  end

  def custom_phases_links(custom_phases)
    current_phase = current_budget.phase
    if current_phase === 'accepting' || current_phase === 'reviewing'
      custom_phases[CUSTOM_PHASE_ACCEPTING].url = budget_investments_url(current_budget, :phase => current_phase)
    elsif current_phase === 'selecting' || current_phase === 'valuating' || current_phase === 'publishing_prices'
      if custom_phases[CUSTOM_PHASE_SELECTING].enabled
        custom_phases[CUSTOM_PHASE_SELECTING].url = budget_investments_url(current_budget, :phase => current_phase)
      else
        custom_phases[CUSTOM_PHASE_ACCEPTING].url = budget_investments_url(current_budget, :phase => current_phase)
      end
    elsif current_phase === 'balloting' || current_phase === 'reviewing_ballots'
      custom_phases[CUSTOM_PHASE_BALLOTING].url = budget_investments_url(current_budget, :phase => current_phase)
    elsif current_phase === 'finished'
      custom_phases[CUSTOM_PHASE_FINISHED].url = budget_investments_url(current_budget, :phase => current_phase)
    end
    custom_phases
  end
end
