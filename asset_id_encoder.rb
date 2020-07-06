#!/usr/bin/env ruby
# frozen_string_literal: true
require './lib/asset_id'

if __FILE__ == $PROGRAM_NAME
  unless ARGV[0]
    puts 'usage: ./asset_id_encoder.rb [filename]'
    return
  end

  File.readlines(ARGV[0]).each do |line|
    asset_id = AssetID.new(line.chomp.chars.map(&:to_i))
    asset_id.generate_image
  end
end
