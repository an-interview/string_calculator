# string_calculator_spec.rb
require 'spec_helper'
require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  describe '.calculate' do
    it 'returns 0 for empty numbers' do
      expect(StringCalculator.calculate('')).to eq(0)
    end

    it 'returns error for non-nombers' do
      expect { StringCalculator.calculate('0,a,5') }.to raise_error(ArgumentError, /\AInput must be a comma-separated string of numbers$/)
    end

    it 'returns 6 for 1,5' do
      expect(StringCalculator.calculate('1,5')).to eq(6)
    end

    it 'return 1 for 1' do
      expect(StringCalculator.calculate('1')).to eq(1)
    end

    it 'return 6 for 1\n2,3' do
      expect(StringCalculator.calculate('1\n2,3')).to eq(6)
    end

    it 'return 10 for 1,2\n3\n4' do
      expect(StringCalculator.calculate('1,2\n3\n4')).to eq(10)
    end

    # dynamic separator
    it 'return 15 for //;1,2\n3;4;5' do
      expect(StringCalculator.calculate('//;1,2\n3;4;5')).to eq(15)
    end

    it 'return 1 for //;1' do
      expect(StringCalculator.calculate('//;1')).to eq(1)
    end

    it 'return error for /1' do
      expect { StringCalculator.calculate('/1') }.to raise_error(ArgumentError)
    end

    it 'return error for //1;2' do
      expect { StringCalculator.calculate('//1;2') }.to raise_error(ArgumentError)
    end

    it 'return error for 1,-2,-3' do
      expect { StringCalculator.calculate('1,-2,-3') }.to raise_error(ArgumentError, /\Anegative numbers not allowed -2,-3$/)
    end
  end
end
