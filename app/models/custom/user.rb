require 'date'
require_dependency Rails.root.join('app', 'models', 'user').to_s

class User < ActiveRecord::Base

  validate :emso_number

  def emso_number
    unless organization
      errors.add(:document_number, I18n.t('activerecord.errors.models.user.attributes.document_number.invalid')) unless valid_emso_number?
    end
  end

  private

  def date_from_emso(emso)
    if emso[4] == '0'
      return Date.parse('2' + emso[4] + emso[5] + emso[6] + '-' + emso[2] + emso[3] + '-' + emso[0] + emso[1])
    else
      return Date.parse('1' + emso[4] + emso[5] + emso[6] + '-' + emso[2] + emso[3] + '-' + emso[0] + emso[1])
    end
  end
  
  def is_old_enough(birthday)
    date_limit = Date.parse('2005-02-26')
    if (date_limit < birthday)
      return false
    end
    return true
  end
  
  def valid_emso_number?
    if /[0123]\d[01]\d[09]\d\d\d{6}/.match(document_number)
      if document_number[12].to_i == 11 - (
        (
          ((document_number[0].to_i + document_number[6].to_i) * 7) + 
          ((document_number[1].to_i + document_number[7].to_i) * 6) + 
          ((document_number[2].to_i + document_number[8].to_i) * 5) + 
          ((document_number[3].to_i + document_number[9].to_i) * 4) + 
          ((document_number[4].to_i + document_number[10].to_i) * 3) + 
          ((document_number[5].to_i + document_number[11].to_i) * 2)
        ) % 11
      )
        return is_old_enough(date_from_emso(document_number))
      elsif document_number[12].to_i == (
          ((document_number[0].to_i + document_number[6].to_i) * 7) + 
          ((document_number[1].to_i + document_number[7].to_i) * 6) + 
          ((document_number[2].to_i + document_number[8].to_i) * 5) + 
          ((document_number[3].to_i + document_number[9].to_i) * 4) + 
          ((document_number[4].to_i + document_number[10].to_i) * 3) + 
          ((document_number[5].to_i + document_number[11].to_i) * 2)
        ) % 11
          return is_old_enough(date_from_emso(document_number))
      else
        return false
      end
    end
    return false
  end
end