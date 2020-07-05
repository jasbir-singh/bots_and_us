class SegmentMappings
  class InvalidDigit < StandardError
    def message
      'Only digits between 0 and 9 are vaild input.'
    end
  end

  ZERO  = '01110111'
  ONE   = '01000010'
  TWO   = '10110110'
  THREE = '11010110'
  FOUR  = '11000011'
  FIVE  = '11010101'
  SIX   = '11110101'
  SEVEN = '01000110'
  EIGHT = '11110111'
  NINE  = '11010111'

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
    if !digit.is_a?(Integer) || digit > 9 || digit < 0
      raise InvalidDigit
    end

    PATTERNS[digit]
  end
end
