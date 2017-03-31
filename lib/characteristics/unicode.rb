# frozen_string_literal: true

require "unicode/categories"

class UnicodeCharacteristics < Characteristics
  BLANKS = [
    0x0009,
    0x0020,
    0x00AD,
    0x034F,
    0x061C,
    0x070F,
    0x115F,
    0x1160,
    0x1680,
    0x17B4,
    0x17B5,
    0x180E,
    0x2000,
    0x2001,
    0x2002,
    0x2003,
    0x2004,
    0x2005,
    0x2006,
    0x2007,
    0x2008,
    0x2009,
    0x200A,
    0x200B,
    0x200C,
    0x200D,
    0x200E,
    0x200F,
    0x202F,
    0x205F,
    0x2060,
    0x2061,
    0x2062,
    0x2063,
    0x2064,
    0x206A,
    0x206B,
    0x206C,
    0x206D,
    0x206E,
    0x206F,
    0x3000,
    0x3164,
    0x2800,
    0xFEFF,
    0xFFA0,
    0x110B1,
    0x1BCA0,
    0x1BCA1,
    0x1BCA2,
    0x1BCA3,
    0x1D159,
    0x1D173,
    0x1D174,
    0x1D175,
    0x1D176,
    0x1D177,
    0x1D178,
    0x1D179,
    0x1D17A,
  ].freeze

  SEPARATORS = [
    0x000A,
    0x000B,
    0x000C,
    0x000D,
    0x0085,
    0x2028,
    0x2029,
  ].freeze

  BIDI_CONTROL = [
    0x061C,
    0x200E,
    0x200F,
    0x202A,
    0x202B,
    0x202C,
    0x202D,
    0x202E,
    0x2066,
    0x2067,
    0x2068,
    0x2069,
  ].freeze

  VARIATION_SELECTORS = [
    *0x180B..0x180D,
    *0xFE00..0xFE0F,
    *0xE0100..0xE01EF,
  ].freeze

  TAGS = [
    0xE0001,
    *0xE0020..0xE007F,
  ].freeze

  NONCHARACTERS = [
    *0xFDD0..0xFDEF,
    0xFFFE,   0xFFFF,
    0x1FFFE,  0x1FFFF,
    0x2FFFE,  0x2FFFF,
    0x3FFFE,  0x3FFFF,
    0x4FFFE,  0x4FFFF,
    0x5FFFE,  0x5FFFF,
    0x6FFFE,  0x6FFFF,
    0x7FFFE,  0x7FFFF,
    0x8FFFE,  0x8FFFF,
    0x9FFFE,  0x9FFFF,
    0xAFFFE,  0xAFFFF,
    0xBFFFE,  0xBFFFF,
    0xCFFFE,  0xCFFFF,
    0xDFFFE,  0xDFFFF,
    0xEFFFE,  0xEFFFF,
    0xFFFFE,  0xFFFFF,
    0x10FFFE, 0x10FFFF,
  ].freeze

  attr_reader :category

  def initialize(char)
    super

    if @is_valid
      @category = Unicode::Categories.category(char)
      @ord = char.ord
    end
  end

  def unicode?
    true
  end

  def assigned?
    @is_valid && @category != "Cn"
  end

  def control?
    @is_valid && @category == "Cc"
  end

  def c0?
    @is_valid && @ord < 0x20
  end

  def delete?
    @is_valid && @ord == 0x7F
  end

  def c1?
    @is_valid && @ord >= 0x80 && @ord < 0xA0
  end

  def blank?
    @is_valid && ( BLANKS.include?(@ord) || SEPARATORS.include?(@ord) )
  end

  def separator?
    @is_valid && SEPARATORS.include?(@ord)
  end

  def format?
    @is_valid && @category == "Cf"
  end

  def bidi_control?
    @is_valid && BIDI_CONTROL.include?(@ord)
  end

  # unicode specific

  def variation_selector?
    @is_valid && VARIATION_SELECTORS.include?(@ord)
  end

  def tag?
    @is_valid && TAGS.include?(@ord)
  end

  def noncharacter?
    @is_valid && NONCHARACTERS.include?(@ord)
  end

  # emoji

  def kddi?
    @is_valid &&
    encoding_has_kddi? &&
    ( @ord >= 0xE468 && @ord <= 0xE5DF ||
      @ord >= 0xEA80 && @ord <= 0xEB8E )
  end

  def softbank?
    @is_valid &&
    encoding_has_softbank? &&
    ( @ord >= 0xE001 && @ord <= 0xE05A ||
      @ord >= 0xE101 && @ord <= 0xE15A ||
      @ord >= 0xE201 && @ord <= 0xE25A ||
      @ord >= 0xE301 && @ord <= 0xE34D ||
      @ord >= 0xE401 && @ord <= 0xE44C ||
      @ord >= 0xE501 && @ord <= 0xE53E )
  end

  def docomo?
    @is_valid &&
    encoding_has_docomo? &&
    ( @ord >= 0xE63E && @ord <= 0xE757 )
  end

  private

  def encoding_has_c1?
    true
  end
end
