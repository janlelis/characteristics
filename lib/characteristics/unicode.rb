require "unicode/categories"

class UnicodeCharacteristics < Characteristics
  BLANKS = [
    0x0009,
    0x0020,
    0x00AD,
    0x115F,
    0x1160,
    0x1680,
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
    0x2028,
    0x2029,
  ].freeze

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
end
