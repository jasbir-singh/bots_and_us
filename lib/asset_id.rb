# frozen_string_literal: true

require './lib/asset_id_image'
require './lib/display_segment_mappings'

class AssetID
  class InvalidAssetID < StandardError
  end

  attr_reader :id

  CHECKSUM_MODULO = 97

  def initialize(input)
    @id = parse_id(input)
  end

  def encode
    "#{checksum(with_leading_digits: true)}#{id.join}".split('').map do |char|
      DisplaySegmentMappings.pattern(char.to_i)
    end.flatten
  end

  def generate_image(file_name: nil)
    image.generate(file_name || "#{id.join}.png")
  end

  private

  def checksum(with_leading_digits: false)
    checksum = id.each_with_index.map do |digit, index|
      digit * (10**index)
    end.sum % CHECKSUM_MODULO

    return checksum unless with_leading_digits
    '%02d' % checksum
  end

  def image
    AssetIDImage.new(encoded_bits: encode)
  end

  def parse_id(input)
    raise InvalidAssetID if input.length > 4 || input.length < 4

    input
  end
end
