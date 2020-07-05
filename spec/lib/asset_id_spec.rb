# frozen_string_literal: true

require 'spec_helper'
require './lib/asset_id'

RSpec.describe AssetID do
  let(:id) { 1337 }
  let(:asset_id) { AssetID.new(id) }

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
