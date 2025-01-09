class StringCalculator
  def self.calculate(input_string)
    return 0 if input_string.strip.empty?

    input_string = convert_to_commas(input_string)
    valid_input?(input_string)
    input_numbers = array_of_numbers(input_string)
    negative_numbers?(input_numbers)

    input_numbers.sum
  end

  def self.valid_input?(input_string)
    raise ArgumentError, 'Input must be a string' unless input_string.is_a?(String)
    raise ArgumentError, 'Input must be a comma-separated string of numbers' unless input_string.split(',').all? { |value| string_valid_number?(value) }
  end

  def self.array_of_numbers(input_string)
    input_string.split(',').map(&:to_i)
  end

  def self.negative_numbers?(input_numbers)
    negative_numbers = []
    negative_numbers = input_numbers.select { |num| num < 0 }

    raise ArgumentError, "negative numbers not allowed #{negative_numbers.join(',')}" if negative_numbers.length > 0

    false
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

# Get the input string from ARGV
input_string = ARGV[0]

if ARGV.empty?
  puts "Please provide a string as an argument."
  exit
end

begin
  puts StringCalculator.calculate(input_string)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end
