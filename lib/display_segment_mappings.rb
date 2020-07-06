# frozen_string_literal: true

class DisplaySegmentMappings
  class InvalidDigit < StandardError
    def message
      'Only digits between 0 and 9 are vaild input.'
    end
  end

  ZERO  = [0, 1, 1, 1, 0, 1, 1, 1].freeze
  ONE   = [0, 1, 0, 0, 0, 0, 1, 0].freeze
  TWO   = [1, 0, 1, 1, 0, 1, 1, 0].freeze
  THREE = [1, 1, 0, 1, 0, 1, 1, 0].freeze
  FOUR  = [1, 1, 0, 0, 0, 0, 1, 1].freeze
  FIVE  = [1, 1, 0, 1, 0, 1, 0, 1].freeze
  SIX   = [1, 1, 1, 1, 0, 1, 0, 1].freeze
  SEVEN = [0, 1, 0, 0, 0, 1, 1, 0].freeze
  EIGHT = [1, 1, 1, 1, 0, 1, 1, 1].freeze
  NINE  = [1, 1, 0, 1, 0, 1, 1, 1].freeze

  PATTERNS = {
    0 => ZERO,
    1 => ONE,
    2 => TWO,
    3 => THREE,
    4 => FOUR,
    5 => FIVE,
    6 => SIX,
    7 => SEVEN,
    8 => EIGHT,
    9 => NINE
  }.freeze

  def self.pattern(digit)
    raise InvalidDigit if !digit.is_a?(Integer) || digit > 9 || digit < 0

    PATTERNS[digit]
  end
end
