require_dependency Rails.root.join('app', 'models', 'user').to_s

class User < ActiveRecord::Base

  validate :emso_number

  def emso_number
    errors.add(:document_number, I18n.t('activerecord.errors.models.user.attributes.document_number.invalid')) unless valid_emso_number?
  end

  private

  def valid_emso_number?
    if /[0,1,2,3]\d[0,1]\d[0,9]\d\d\d{6}/.match(document_number)
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
        return true
      elsif document_number[12].to_i == (
          ((document_number[0].to_i + document_number[6].to_i) * 7) + 
          ((document_number[1].to_i + document_number[7].to_i) * 6) + 
          ((document_number[2].to_i + document_number[8].to_i) * 5) + 
          ((document_number[3].to_i + document_number[9].to_i) * 4) + 
          ((document_number[4].to_i + document_number[10].to_i) * 3) + 
          ((document_number[5].to_i + document_number[11].to_i) * 2)
        ) % 11
          return true
      else
        return false
      end
    end
    return false
  end
end