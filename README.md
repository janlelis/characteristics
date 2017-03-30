# Characteristics [![[version]](https://badge.fury.io/rb/characteristics.svg)](http://badge.fury.io/rb/characteristics)  [![[travis]](https://travis-ci.org/janlelis/characteristics.svg)](https://travis-ci.org/janlelis/characteristics)

A Ruby library which provides some basic information about how characters behave in different encodings:

- Is a character valid according to its encoding?
- Is a character assigned?
- Is a character a special control character?
- Could a character be invisible (blank)?

The [unibits](https://github.com/janlelis/unibits) and [uniscribe](https://github.com/janlelis/uniscribe) gems makes use of this data to visualize it accordingliy.

## Setup

Add to your `Gemfile`:

```ruby
gem 'characteristics'
```

## Usage

```ruby
char_info = Characteristics.create(character)
char_info.valid? # => true / false
char_info.unicode? # => true / false
char_info.assigned? # => true / false
char_info.control? # => true / false
char_info.blank? # => true / false
char_info.separator? # => true / false
char_info.format? # => true / false
```

## Types of Encodings

This library knows of four different kinds of encodings:

- **:unicode** Unicode familiy of multi-byte encodings
  - *UTF-X*
- **:byte** Known single-byte encoding
  - *ISO-8859-X*, *Windows-125X*, *IBMX*, *CP85X*, *macX*, *TIS-620*, *Windows-874*, *KOI-X*
- **:ascii** 7-Bit ASCII
  - *US-ASCII*, *GB1988*
- **:binary** Arbitrary string
  - *ASCII-8BIT*

Other encodings are not supported, yet.

## Predicates

### `valid?`

Validness is determined by Ruby's `String#valid_encoding?`

### `unicode?`

`true` for Unicode encodings (`UTF-X`)

### `control?`

Control characters are codepoints in the is [C0, delete or C1 control character range](https://en.wikipedia.org/wiki/C0_and_C1_control_codes). Characters in this range of [IBM codepage 437](https://en.wikipedia.org/wiki/Code_page_437) based encodings are always treated as control characters.

### `assigned?`

- All valid ASCII and BINARY characters are considered assigned
- For other byte based encodings, a character is considered assigned if it is not on the exception list included in this library. C0 control characters (and `\x7F`) are always considered assigned. C1 control characters are treated as assigned, if the encoding generally does not assign characters in the C1 region.
- For Unicode, the general category is considered

### `blank?`

The library includes a list of characters that might not be rendered visually. This list does not include unassigned codepoints, control characters (except for `\t`, `\n`, `\v`, `\f`, `\r`, and `\u{85}` in Unicode), or special formatting characters (right-to-left markers, variation selectors, etc).

### `separator?`

Returns true if character is considered a separator. All separators also return true for the `blank?` check. In Unicode, the following characters are separators: `\n`, `\v`, `\f`, `\r`, `\u{85}` (next line), `\u{2028}` (line separator), and `\u{2029}` (paragraph separator)

### `format?`

This flag is `true` only for special formatting characters, which are not control characters, like Right-to-left marks. In Unicode, this means codepoints with the General Category of **Cf**.

## Todo

- Support all non-dummy encodings that Ruby supports

## MIT License

Copyright (C) 2017 Jan Lelis <http://janlelis.com>. Released under the MIT license.
