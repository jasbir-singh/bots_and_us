# frozen_string_literal: true

require 'chunky_png'
require 'pry'

class AssetIDImage
  attr_reader :bits, :image

  MIN_BOUND = 8
  MAX_BOUND = 55
  IMAGE_WIDTH = 256
  IMAGE_HEIGHT = 1

  def initialize(encoded_bits: [])
    @bits = Array.new(256, 0).tap do |array|
      (MIN_BOUND..MAX_BOUND).each do |index|
        array[index] = encoded_bits[index - 8] || 0
      end
    end

    @image = ChunkyPNG::Image.new(IMAGE_WIDTH, IMAGE_HEIGHT, ChunkyPNG::Color::TRANSPARENT)
  end

  def generate(file_name = 'asset_id.png')
    bits.each_with_index do |i, index|
      image[index, 0] = ChunkyPNG::Color(pixel_color(i))
    end

    image.save(file_name, interlace: true)
  end

  private

  def pixel_color(bit)
    return 'black' if bit == 1

    'white'
  end
end
