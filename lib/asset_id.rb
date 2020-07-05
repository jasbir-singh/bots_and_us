# frozen_string_literal: true

class DisplayMappings
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

  REPRESENTATIONS = {
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

  def self.mapping(i)
    REPRESENTATIONS[i]
  end
end

class AssetID
  attr_reader :id

  CHECKSUM_MODULO = 97

  def initialize(id)
    @id = id
  end

  def with_checksum
    "#{checksum}#{id}".to_i
  end

  def encode
    with_checksum.to_s.split('').map { |char| DisplayMappings::REPRESENTATIONS[char.to_i] }.join
  end

  # c = (a1 + (10 * a2) + (100 * a3) + (1000 * a4)) mod 97
  def checksum
    id.digits.reverse.each_with_index.map do |digit, index|
      digit * (10**index)
    end.sum % CHECKSUM_MODULO
  end
end
