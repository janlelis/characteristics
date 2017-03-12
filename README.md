# Characteristics [![[version]](https://badge.fury.io/rb/characteristics.svg)](http://badge.fury.io/rb/characteristics)  [![[travis]](https://travis-ci.org/janlelis/characteristics.svg)](https://travis-ci.org/janlelis/characteristics)

A Ruby library which provides some basic information about how characters behave in different encodings:

- Is a character valid according to its encoding?
- Is a character assigned?
- Is a character a special control character?
- Could a character be invisible (blank)?

The [unibits](https://github.com/janlelis/unibits) gem makes use of this data to visualize it accordingliy.

## Setup

Add to your `Gemfile`:

```ruby
gem 'characteristics'
```

## Usage

```ruby
char_info = Characteristics.new(character)
char_info.valid? # => true / false
char_info.unicode? # => true / false
char_info.assigned? # => true / false
char_info.control? # => true / false
char_info.blank? # => true / false
```

## Types of Encodings

This library knows of four different kinds of encodings:

- **:unicode** Unicode familiy of multibyte encodings (*UTF-X*)
- **:ascii** 7-Bit ASCII (*US-ASCII*)
- **:binary** Arbitrary string (*ASCII-8BIT*)
- **:byte** Known byte encoding (*ISO-8859-X*, *Windows-X*)

Other encodings are not supported, yet.

## Predicates

### `valid?`

Validness is determined by Ruby's String#valid_encoding?

### `unicode?`

`true` for Unicode encodings (`UTF-X`)

### `control?`

Control characters are codepoints in the is [C0, delete or C1 control character range](https://en.wikipedia.org/wiki/C0_and_C1_control_codes).

### `assigned?`

- All valid ASCII and BINARY characters are considered assigned
- For other byte based encodings, a character is considered assigned if it is not on the exception list included in this library. C0 control characters (and `\x7F`) are always considered assigned. C1 control characters are treated as assigned, if the encoding generally does not assign characters in the C1 region.
- For Unicode, the general category is considered

### `blank?`

The library includes a list of characters that might not be rendered visually. This list does not include unassigned codepoints, control characters (except for `\t`, `\n`, `\v`, `\f`, `\r`), or special formatting characters (right-to-left marker, variation selectors, etc).

## Todo

- Support all non-dummy encodings that Ruby supports
- Complete test matrix

## MIT License

Copyright (C) 2017 Jan Lelis <http://janlelis.com>. Released under the MIT license.
