require_dependency Rails.root.join('app', 'models', 'budget', 'investment').to_s

class Budget
  class Investment < ActiveRecord::Base

    # remove existing validator hack
    self.class_eval do
      _validators[:title]
        .find { |v| v.is_a? ActiveRecord::Validations::PresenceValidator }
        .attributes
        .delete(:title)
    end

  end
end
