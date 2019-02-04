require_dependency Rails.root.join('app', 'models', 'officing', 'residence').to_s

class Officing::Residence

  reset_callbacks(:before_validation)

  # remove existing validators
  self.class_eval do
    _validators[:year_of_birth]
      .find { |v| v.is_a? ActiveRecord::Validations::PresenceValidator }
      .attributes
      .delete(:year_of_birth)
  end

  def allowed_age
    true
  end

  def residence_in_madrid
    true
  end

end
