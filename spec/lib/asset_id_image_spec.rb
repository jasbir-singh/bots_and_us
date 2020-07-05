# frozen_string_literal: true

require './lib/asset_id_image'

RSpec.describe AssetIDImage do
  let(:code) { ('1' * 48).split('').map(&:to_i) }
  let(:asset_id_image) { AssetIDImage.new(encoded_bits: code) }

  describe '#image' do
    it 'creates an image' do
      expect(ChunkyPNG::Image).to receive(:new).with(256, 1, ChunkyPNG::Color::TRANSPARENT)

      asset_id_image
    end
  end

  describe '#bits' do
    it 'does not alter first 8 bits' do
      (0..7).each do |i|
        expect(asset_id_image.bits[i]).to eq(0)
      end
    end

    it 'the bits from 8-55 bits' do
      expect(asset_id_image.bits[8..(code.length + 7)]).to eq(code)
    end
  end

  describe '#generate' do
    let(:image) { asset_id_image.image }

    it 'returns arrows' do
      (0..7).each do |i|
        expect(image).to receive(:[]=).with(i, 0, ChunkyPNG::Color('white'))
      end

      (8..55).each do |i|
        expect(image).to receive(:[]=).with(i, 0, ChunkyPNG::Color('black'))
      end

      (56..255).each do |i|
        expect(image).to receive(:[]=).with(i, 0, ChunkyPNG::Color('white'))
      end

      asset_id_image.generate
    end
  end
end
