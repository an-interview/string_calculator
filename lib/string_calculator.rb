class StringCalculator
  def self.calculate(input)
    if input.is_a?(String)
      if input.strip.empty?
        return 0
      end

      unless valid_comma_separated_numbers?(input)
        raise ArgumentError, 'Input must be a comma-separated string of numbers'
      end

      input = replace_new_lines_with_commas(input)
      numbers = input.split(/[,\n]/).map(&:strip).map(&:to_i)

      numbers.sum(&:to_i)
    else
      raise ArgumentError, 'Input must be a string'
    end
  end

  def self.valid_comma_separated_numbers?(input)
    input = replace_new_lines_with_commas(input)
    input.split(',').all? { |value| valid_number?(value.strip) }
  end

  def self.valid_number?(value)
    value.match?(/^\d+$/)
  end

  def self.replace_new_lines_with_commas(input)
    input = input.gsub('\\n', "\n")
    input.gsub(/\n/, ',') # handle new lines
  end
end
