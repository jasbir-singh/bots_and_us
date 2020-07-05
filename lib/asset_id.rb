# frozen_string_literal: true

require './lib/asset_id_image'
require './lib/segment_mappings'

class AssetID
  class InvalidAssetID < StandardError
  end

  attr_reader :id

  CHECKSUM_MODULO = 97

  def initialize(input)
    @id = parse_id(input)
  end

  def encode
    "#{checksum}#{id.join}".split('').map do |char|
      SegmentMappings.pattern(char.to_i)
    end.flatten
  end

  def to_image(file_name: nil)
    image.generate(file_name || "#{id.join}.png")
  end

  def checksum
    id.each_with_index.map do |digit, index|
      digit * (10**index)
    end.sum % CHECKSUM_MODULO
  end

  private

  def image
    AssetIDImage.new(encoded_bits: encode)
  end

  def parse_id(input)
    raise InvalidAssetID if input.length > 4 || input.length < 4

    input
  end
end
