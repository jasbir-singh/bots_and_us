# frozen_string_literal: true

require './lib/asset_id_image'
require './lib/segment_mappings'

class AssetID
  class InvalidAssetID < StandardError
  end

  attr_reader :id

  MINIMUM_ID = 0
  MAXIMUM_ID = 9999
  CHECKSUM_MODULO = 97

  def initialize(input)
    @id = parse_id(input)
  end

  def encode
    "#{checksum}#{id}".split('').map { |char| SegmentMappings.pattern(char.to_i) }.join
  end

  def to_image(file_name: nil)
    AssetIDImage.new(encode).generate(file_name || "#{with_checksum}.png")
  end

  # c = (a1 + (10 * a2) + (100 * a3) + (1000 * a4)) mod 97
  def checksum
    id.digits.reverse.each_with_index.map do |digit, index|
      digit * (10**index)
    end.sum % CHECKSUM_MODULO
  end

  private

  def parse_id(input)
    output = Integer(input)
    raise InvalidAssetID if (output > MAXIMUM_ID) || (output < MINIMUM_ID)

    output
  rescue ArgumentError
    raise InvalidAssetID
  end
end
