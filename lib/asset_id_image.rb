require 'chunky_png'

class AssetIDImage
  attr_reader :bits, :image

  def initialize(code)
    @bits = Array.new(256, 0).tap do |array|
      code.split('').each_with_index do |char, i|
        array[i + 8] = char.to_i
      end
    end

    @image = ChunkyPNG::Image.new(256, 1, ChunkyPNG::Color::TRANSPARENT)
  end

  def generate(file_name = 'asset_id.png')
    bits.each_with_index do |i, index|
      image[index,0] = ChunkyPNG::Color(pixel_color(i))
    end

    image.save(file_name, :interlace => true)
  end

  private

  def pixel_color(bit)
    return 'black' if bit == 1

    'white'
  end
end
