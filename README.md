# Approach

## Why ruby?

- Good support for PNG libraries (ChunkyPNG, OilyPNG, RMagick, etc..).
- Performance should be adequate for the given task.

## Design approach

### Classes
- `AssetID` - It encapsulates the logic validating, generating checksum, and encoding the asset id.
For representing bit strings, I chose to use array of bits everywhere for consistency.

- `AssetIDIMage` - It encapsulates the logic for converting an asset id to a png image. It uses the library `chunky_png` (pure ruby implementation) for generating pngs (which might not potentially scale if we are generating a lot of PNGs).

- `DisplaySegmentMappings` - It handles the logic for encoding each digit to a 8 bit array. I have worked all bit array mappings manually.

### Improvements/TODOs

- Bit array mappings have been worked out manually encoded as array bits. A DSL for building the mappings might be less error prone.

A DSL might look something like this.
```ruby
seven = EightBitArray.new do |bits|
	bits.on(1, 5, 6)
end
```

or 

```ruby
seven = EightBitArray.new do |bits|
	bits.on(1)
	bits.on(5)
	bits.on(6)
end
```
- Add integration test for testing that the generated png is actually correct.

# How to run the code?

## Running via command line

```sh
./asset_id_encoder.rb test.txt
```

## Generating via ruby script

Load class `AssetID`

```ruby
require './lib/asset_id'
```

Then generate the image

```ruby
asset_id = AssetID.new([1, 3, 3, 7])
asset_id.generate_image
```
