class StringCalculator
  def self.calculate(input_string)
    if input_string.is_a?(String)
      if input_string.strip.empty?
        return 0
      end

      input_numbers = array_of_numbers(input_string)
      valid_comma_separated_numbers?(input_numbers)

      input_numbers.sum
    else
      raise ArgumentError, 'Input must be a string'
    end
  end

  def self.array_of_numbers(input_string)
    input = convert_to_commas(input_string)

    raise ArgumentError, 'Input must be a comma-separated string of positive numbers' unless input.split(',').all? { |value| string_valid_number?(value) }

    input.split(',').map(&:to_i)
  end

  def self.valid_comma_separated_numbers?(input_numbers)
    negative_numbers = []
    negative_numbers = input_numbers.select { |num| num < 0 }

    raise ArgumentError, "negative numbers not allowed #{negative_numbers.join(',')}" if negative_numbers.length > 0
  end

  def self.string_valid_number?(value)
    # allowing negative numbers at this stage, to maintain sequence of errors raised
    value.match?(/^[-+]?\d+$/)
  end

  def self.convert_to_commas(input_string)
    # handle dynamic seperator
    if input_string.start_with?('//') && input_string.length > 2
      dynamic_separator = input_string[2]
      input_string = input_string.slice(3..-1)
      input_string = input_string.gsub(dynamic_separator, ',')
    end

    input_string = input_string.gsub("\\n", "\n")
    input_string.gsub(/\n/, ',') # handle new lines
  end
end
