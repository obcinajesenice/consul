if Rails.env.development?
  require 'database_cleaner'
  DatabaseCleaner.clean_with :truncation
end

@logger = Logger.new(STDOUT)
@logger.formatter = proc do |_severity, _datetime, _progname, msg|
                      msg unless @avoid_log
                    end

def section(section_title)
  @logger.info section_title
  yield
  log(' ✅')
end

def log(msg)
  @logger.info "#{msg}\n"
end

def random_locales
  [I18n.default_locale, *I18n.available_locales.sample(4)].uniq
end

require_relative 'less_seeds/settings'
#require_relative 'dev_seeds/geozones'
require_relative 'less_seeds/users'
require_relative 'less_seeds/tags'
#require_relative 'dev_seeds/tags_categories'
# require_relative 'dev_seeds/debates'
# require_relative 'dev_seeds/proposals'
#require_relative 'less_seeds/budgets'
# require_relative 'dev_seeds/spending_proposals'
# require_relative 'dev_seeds/comments'
# require_relative 'dev_seeds/votes'
# require_relative 'dev_seeds/flags'
# require_relative 'dev_seeds/hiddings'
# require_relative 'dev_seeds/banners'
# require_relative 'dev_seeds/polls'
# require_relative 'dev_seeds/communities'
# require_relative 'less_seeds/legislation_processes'
# require_relative 'dev_seeds/newsletters'
# require_relative 'dev_seeds/notifications'
#require_relative 'dev_seeds/widgets'
#require_relative 'dev_seeds/admin_notifications'
# require_relative 'dev_seeds/legislation_proposals'
# require_relative 'less_seeds/content_blocks'
#require_relative 'dev_seeds/milestones'

log "All less seeds created successfuly 👍"
