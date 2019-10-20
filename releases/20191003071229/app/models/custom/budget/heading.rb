require_dependency Rails.root.join('app', 'models', 'budget', 'heading').to_s

class Budget
  class Heading < ActiveRecord::Base

    translates :name, touch: true
    include Globalizable

  end
end