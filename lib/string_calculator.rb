class StringCalculator
  def self.calculate(input)
    if input.is_a?(String)
      if input.strip.empty?
        return 0
      end

      unless valid_comma_separated_numbers?(input)
        raise ArgumentError, 'Input must be a comma-separated string of numbers'
      end

      numbers = input.split(',').map(&:strip)
      total = 0
      numbers.each do |number|
        total += number.to_i
      end
      total
    else
      raise ArgumentError, 'Input must be a string'
    end
  end

  def self.valid_comma_separated_numbers?(input)
    input.split(',').all? { |value| valid_number?(value.strip) }
  end

  def self.valid_number?(value)
    value.match?(/^\d+$/)
  end
end
