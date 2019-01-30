require 'date'

def valid_emso_number(document_number)
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
  false
end

include DocumentParser
class LocalCensus

  def call(document_type, document_number)
    record = nil
    # get_document_number_variants(document_type, document_number).each do |variant|
    puts 'LocalCensusVariants'
    record = Response.new(get_record(document_number))
    puts record
    puts 'IS RECORD VALID?'
    puts record.valid?
    return record if record.valid?
    # end
    record
  end

  class Response
    def initialize(body)
      puts 'INITIALIZING'
      @body = body
    end

    def valid?
      puts 'PUTTING BODY'
      puts @body
      # @body.present? ? !@body.attributes.values.include?("" || nil) : false
    # rescue
      valid_emso_number(@body[:document_number])
    end

    def date_of_birth
      date_from_emso(@body[:document_number])
    end

    def postal_code
      @body.postal_code
    rescue
      nil
    end

    def district_code
        @body.district_code
    rescue
        nil
    end

    def gender
      case @body.gender
      when "Varón"
        "male"
      when "Mujer"
        "female"
      end
    rescue NoMethodError
      nil
    end

    def name
        "#{@body.nombre} #{@body.apellido1}"
    rescue
        nil
    end

    private

      def data
        @body.attributes
      end
  end

  private

    def get_record(document_number)
      # puts LocalCensusRecord.find_by(document_number: document_number)
      # LocalCensusRecord.find_by(document_number: document_number)
      return {
        document_number: document_number,
      }
    end

    def dni?(document_type)
      document_type.to_s == "1"
    end

    def date_from_emso(emso)
      if emso[4] == '0'
        return Date.parse('2' + emso[4] + emso[5] + emso[6] + '-' + emso[2] + emso[3] + '-' + emso[0] + emso[1])
      else
        return Date.parse('1' + emso[4] + emso[5] + emso[6] + '-' + emso[2] + emso[3] + '-' + emso[0] + emso[1])
      end
    end

end
