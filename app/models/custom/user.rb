require_dependency Rails.root.join('app', 'models', 'user').to_s

class User < ActiveRecord::Base

  validate :emso_number

  def emso_number
    errors.add(:document_number, I18n.t('activerecord.errors.models.user.attributes.document_number.invalid')) unless valid_emso_number?
  end

  private

  def valid_emso_number?
    /[0,1,2,3]\d[0,1]\d{4}50[0,5]\d{3}/.match(document_number)
  end

end
