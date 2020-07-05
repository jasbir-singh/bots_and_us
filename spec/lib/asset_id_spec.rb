# frozen_string_literal: true

require 'spec_helper'
require './lib/asset_id'

RSpec.describe AssetID do
  let(:id) { 1337 }
  let(:asset_id) { AssetID.new(id) }

  describe 'contstructor' do
    context 'when the id is invalid' do
      let(:id) { 99999 }

      it 'raises an error' do
        expect {
          asset_id
        }.to raise_error(AssetID::InvalidAssetID)
      end
    end

    context 'when the id is valid' do
      let(:id) { 9999 }

      it 'does not raise an error' do
        expect(asset_id).to be_a_kind_of(described_class)
      end
    end
  end

  describe '.checksum' do
    subject { asset_id.checksum }

    it { is_expected.to eq(56) }
  end

  describe '.with_checksum' do
    subject { asset_id.with_checksum }

    it { is_expected.to eq(561_337) }
  end

  describe '.encode' do
    let(:result) { '110101011111010101000010110101101101011001000110' }
    subject { asset_id.encode }

    it { is_expected.to eq(result) }
  end
end
