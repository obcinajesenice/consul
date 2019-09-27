module Abilities
  class Common
    include CanCan::Ability

    def initialize(user)
      merge Abilities::Everyone.new(user)
      # THIS USED TO BE IN ABILITIES EVERYONE
      can [:read, :map], Debate
      can [:read, :map, :summary, :share], Proposal
      can :read, Comment
      can :read, Poll
      can :results, Poll do |poll|
        poll.expired? && poll.results_enabled?
      end
      can :stats, Poll do |poll|
        poll.expired? && poll.stats_enabled?
      end
      can :read, Poll::Question
      can :read, User
      can [:read, :welcome], Budget
      can [:read], Budget
      can [:read], Budget::Group
      can [:read, :print, :json_data], Budget::Investment
      can(:read_results, Budget) { |budget| budget.results_enabled? && budget.finished? }
      can(:read_stats, Budget) { |budget| budget.stats_enabled? && budget.valuating_or_later? }
      can :read_executions, Budget, phase: "finished"
      can :new, DirectMessage
      can [:read, :debate, :draft_publication, :allegations, :result_publication,
           :proposals, :milestones], Legislation::Process, published: true
      can :resume, Legislation::Process do |process|
        process.past?
      end
      can [:read, :changes, :go_to_version], Legislation::DraftVersion
      can [:read], Legislation::Question
      can [:read, :map, :share], Legislation::Proposal
      can [:search, :comments, :read, :create, :new_comment], Legislation::Annotation
      # END WHAT USED TO BE IN ABILITIES EVERYONE

      can [:read, :update], User, id: user.id

      can :read, Debate
      can :update, Debate do |debate|
        debate.editable_by?(user)
      end

      can :read, Proposal
      can :update, Proposal do |proposal|
        proposal.editable_by?(user)
      end
      can :publish, Proposal do |proposal|
        proposal.draft? && proposal.author.id == user.id && !proposal.retired?
      end
      can :dashboard, Proposal do |proposal|
        proposal.author.id == user.id
      end
      can :manage_polls, Proposal do |proposal|
        proposal.author.id == user.id
      end
      can :manage_mailing, Proposal do |proposal|
        proposal.author.id == user.id
      end
      can :manage_poster, Proposal do |proposal|
        proposal.author.id == user.id
      end

      can :results, Poll do |poll|
        poll.related&.author&.id == user.id
      end

      can [:retire_form, :retire], Proposal, author_id: user.id

      can :read, Legislation::Proposal
      cannot [:edit, :update], Legislation::Proposal do |proposal|
        proposal.editable_by?(user)
      end
      can [:retire_form, :retire], Legislation::Proposal, author_id: user.id

      can :create, Comment
      can :create, Debate
      can [:create, :created], Proposal
      can :create, Legislation::Proposal

      can :suggest, Debate
      can :suggest, Proposal
      can :suggest, Legislation::Proposal
      can :suggest, ActsAsTaggableOn::Tag

      can [:flag, :unflag], Comment
      cannot [:flag, :unflag], Comment, user_id: user.id

      can [:flag, :unflag], Debate
      cannot [:flag, :unflag], Debate, author_id: user.id

      can [:flag, :unflag], Proposal
      cannot [:flag, :unflag], Proposal, author_id: user.id

      can [:flag, :unflag], Legislation::Proposal
      cannot [:flag, :unflag], Legislation::Proposal, author_id: user.id

      can [:flag, :unflag], Budget::Investment
      cannot [:flag, :unflag], Budget::Investment, author_id: user.id

      can [:create, :destroy], Follow

      can [:destroy], Document do |document|
        document.documentable.try(:author_id) == user.id
      end

      can [:destroy], Image, imageable: { author_id: user.id }

      can [:create, :destroy], DirectUpload

      unless user.organization?
        can :vote, Debate
        can :vote, Comment
      end

      if user.level_two_or_three_verified?
        can :vote, Proposal do |proposal|
          proposal.published?
        end
        can :vote_featured, Proposal

        can :vote, Legislation::Proposal
        can :vote_featured, Legislation::Proposal
        can :create, Legislation::Answer

        can :create, Budget::Investment,               budget: { phase: "accepting" }
        can :suggest, Budget::Investment,              budget: { phase: "accepting" }
        can :destroy, Budget::Investment,              budget: { phase: ["accepting", "reviewing"] }, author_id: user.id
        can :vote, Budget::Investment,                 budget: { phase: "selecting" }

        can [:show, :create], Budget::Ballot,          budget: { phase: "balloting" }
        can [:create, :destroy], Budget::Ballot::Line, budget: { phase: "balloting" }

        can :create, DirectMessage
        can :show, DirectMessage, sender_id: user.id

        can [:load_answers], Poll::Question
        can [:answer], Poll do |poll|
          poll.answerable_by?(user)
        end
        can [:answer, :prioritized_answers], Poll::Question do |question|
          question.answerable_by?(user)
        end

        can [:create, :delete], Poll::Answer do |answer|
          answer.question.answerable_by?(user)
        end
      end

      can [:create, :show], ProposalNotification, proposal: { author_id: user.id }

      can [:create], Topic
      can [:update, :destroy], Topic, author_id: user.id

      can :disable_recommendations, [Debate, Proposal]
    end
  end
end
