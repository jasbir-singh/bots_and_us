# frozen_string_literal: true

require './lib/display_segment_mappings'

RSpec.describe DisplaySegmentMappings do
  describe 'hash map PATTERNS' do
    let(:mapping) { DisplaySegmentMappings::PATTERNS }

    it 'has values for all the digits' do
      expect(mapping.keys). to eq((0..9).to_a)
    end

    it 'has all the values of length 8' do
      mapping.each do |_, val|
        expect(val.length).to eq(8)
      end
    end

    it 'all the values have 4th bit off' do
      mapping.each do |_, val|
        expect(val[4]).to eq(0)
      end
    end
  end

  describe '.pattern' do
    subject { described_class.pattern(digit) }

    context 'with invalid input' do
      let(:digit) { '0' }

      it 'raises an error' do
        expect do
          subject
        end.to raise_error(DisplaySegmentMappings::InvalidDigit)
      end
    end
  end
end
