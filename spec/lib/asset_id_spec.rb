require 'spec_helper'

class AssetID
  attr_reader :id
  def initialize(id)
    @id = id
  end

  def with_checksum
    "#{checksum}#{id}".to_i
  end

  def encode
  end

  # c = (a1 + (10 * a2) + (100 * a3) + (1000 * a4)) mod 97
  def checksum
    sum = id.digits.reverse.each_with_index.map { |digit, index| digit * (10 ** index)  }.sum
    sum % 97
  end
end

RSpec.describe AssetID do
  let(:asset_id) { AssetID.new(1337) }

  describe '.checksum' do
    subject { asset_id.checksum }

    it { is_expected.to eq(56) }
  end

  describe '.with_checksum' do
    subject { asset_id.with_checksum }

    it { is_expected.to eq(561337) }
  end
end
