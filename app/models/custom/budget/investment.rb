require_dependency Rails.root.join('app', 'models', 'budget', 'investment').to_s

class Budget
  class Investment < ActiveRecord::Base

    # change some defaults
    documentable max_documents_allowed: 5,
                 max_file_size: 3.megabytes,
                 accepted_content_types: [ "application/pdf" ]

    # remove existing validator
    self.class_eval do
      _validators[:title]
        .find { |v| v.is_a? ActiveRecord::Validations::PresenceValidator }
        .attributes
        .delete(:title)
    end

    def should_show_ballots?
      (budget.balloting? && selected?) || (budget.reviewing_ballots?)
    end

    def should_show_vote_count?
      budget.finished?
    end

  end
end
