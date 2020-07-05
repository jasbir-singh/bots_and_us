# frozen_string_literal: true

require './lib/asset_id_image'
require './lib/segment_mappings'

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
    with_checksum.to_s.split('').map { |char| SegmentMappings::PATTERNS[char.to_i] }.join
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
end
