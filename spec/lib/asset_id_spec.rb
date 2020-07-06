# frozen_string_literal: true

require 'spec_helper'
require './lib/asset_id'

RSpec.describe AssetID do
  let(:id) { [1, 3, 3, 7] }
  let(:asset_id) { AssetID.new(id) }

  describe 'contstructor' do
    context 'when the id is invalid' do
      let(:id) { [9, 9, 9, 9, 9] }

      context 'when the id is an integer' do
        it 'raises an error' do
          expect do
            asset_id
          end.to raise_error(AssetID::InvalidAssetID)
        end
      end

      context 'when the id is a string' do
        let(:id) { '99999' }
        it 'raises an error' do
          expect do
            asset_id
          end.to raise_error(AssetID::InvalidAssetID)
        end
      end
    end

    context 'valid id' do
      context 'when the id is a single digit number' do
        let(:id) { [0, 0, 0, 1] }

        it 'does not raise an error' do
          expect(asset_id.id).to eq([0, 0, 0, 1])
        end
      end

      context 'when the id is a three digit number' do
        let(:id) { [0, 1, 2, 3] }

        it 'does not raise an error' do
          expect(asset_id.id).to eq([0, 1, 2, 3])
        end
      end

      context 'when the id is a number' do
        let(:id) { [9, 9, 9, 9] }

        it 'does not raise an error' do
          expect(asset_id.id).to eq([9, 9, 9, 9])
        end
      end

      context 'when the id is a string' do
        let(:id) { [9, 9, 9, 9] }

        it 'does not raise an error' do
          expect(asset_id.id).to eq([9, 9, 9, 9])
        end
      end
    end
  end

  describe '#checksum' do
    subject { asset_id.send(:checksum) }

    describe 'cases when checksum is zero' do
      context 'when id is 0' do
        let(:id) { [0, 0, 0, 0] }

        # 0 mod 97
        it { is_expected.to eq(0) }
      end

      context 'when id is 79' do
        let(:id) { [0, 0, 7, 9] }

        # 9700 mod 97
        it { is_expected.to eq(0) }
      end

      context 'when id is 584' do
        let(:id) { [0, 5, 8, 4] }

        # 4850 mod 97
        it { is_expected.to eq(0) }
      end

      context 'when id is 5541' do
        let(:id) { [5, 5, 4, 1] }

        # 1455 mod 97
        it { is_expected.to eq(0) }
      end
    end

    context 'when id is 1337' do
      it { is_expected.to eq(56) }
    end

    context 'when id is 1000' do
      let(:id) { [1, 0, 0, 0] }

      # 1000 mod 97
      it { is_expected.to eq(1) }
    end

    context 'when id is 9000' do
      let(:id) { [9, 0, 0, 0] }

      # 1000 mod 97
      it { is_expected.to eq(9) }
    end

    context 'when id is 0100' do
      let(:id) { [0, 1, 0, 0] }

      it { is_expected.to eq(10) }
    end
  end

  describe '#generate_image' do
    let(:image_double) { double(AssetIDImage) }
    let(:encoded_bits) { '110101011111010101000010110101101101011001000110'.split('').map(&:to_i) }

    it 'creates a image' do
      expect(AssetIDImage).to receive(:new).with(encoded_bits: encoded_bits).and_return(image_double)
      expect(image_double).to receive(:generate).with('1337.png')

      asset_id.generate_image
    end
  end

  describe '#encode' do
    subject { asset_id.encode }

    describe 'when id is 1337' do
      let(:encoded_bits) { '110101011111010101000010110101101101011001000110'.split('').map(&:to_i) }

      it { is_expected.to eq(encoded_bits) }
    end
  end
end
