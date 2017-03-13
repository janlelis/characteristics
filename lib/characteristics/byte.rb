class ByteCharacteristics < Characteristics
  HAS_C1 = /^(ISO-8859-)/

  UNASSIGNED = {
    0x80 => /^(IBM869)/,
    0x81 => /^(Windows-(1250|1252|1253|1254|1255|1257|1258)|IBM869)/,
    0x82 => /^(IBM869)/,
    0x83 => /^(Windows-(1250|1257)|IBM869)/,
    0x84 => /^(IBM869)/,
    0x85 => /^(IBM869)/,
    0x87 => /^(IBM869)/,
    0x88 => /^(Windows-(1250|1253|1257))/,
    0x8A => /^(Windows-(1253|1255|1257|1258))/,
    0x8C => /^(Windows-(1253|1255|1257))/,
    0x8D => /^(Windows-(1252|1253|1254|1255|1258))/,
    0x8E => /^(Windows-(1253|1254|1255|1258))/,
    0x8F => /^(Windows-(1252|1253|1254|1255|1258))/,

    0x90 => /^(Windows-(1250|1252|1253|1254|1255|1257|1258))/,
    0x93 => /^(IBM869)/,
    0x94 => /^(IBM869)/,
    0x98 => /^(Windows-(1250|1251|1253|1257))/,
    0x9A => /^(Windows-(1253|1255|1257|1258))/,
    0x9B => /^(IBM864)/,
    0x9C => /^(Windows-(1253|1255|1257)|IBM864)/,
    0x9D => /^(Windows-(1252|1253|1254|1255|1258))/,
    0x9E => /^(Windows-(1253|1254|1255|1258))/,
    0x9F => /^(Windows-(1253|1255|1257)|IBM864)/,

    0xA1 => /^(ISO-8859-(6|8)|Windows-(1257))/,
    0xA2 => /^(ISO-8859-(6))/,
    0xA3 => /^(ISO-8859-(6))/,
    0xA5 => /^(ISO-8859-(3|6)|Windows-(1257))/,
    0xA6 => /^(ISO-8859-(6)|IBM864)/,
    0xA7 => /^(ISO-8859-(6))/,
    0xA8 => /^(ISO-8859-(6))/,
    0xA9 => /^(ISO-8859-(6))/,
    0xAA => /^(ISO-8859-(6)|Windows-(1253))/,
    0xAB => /^(ISO-8859-(6))/,
    0xAE => /^(ISO-8859-(3|6|7))/,
    0xAF => /^(ISO-8859-(6))/,

    0xB0 => /^(ISO-8859-(6))/,
    0xB1 => /^(ISO-8859-(6))/,
    0xB2 => /^(ISO-8859-(6))/,
    0xB3 => /^(ISO-8859-(6))/,
    0xB4 => /^(ISO-8859-(6))/,
    0xB5 => /^(ISO-8859-(6))/,
    0xB6 => /^(ISO-8859-(6))/,
    0xB7 => /^(ISO-8859-(6))/,
    0xB8 => /^(ISO-8859-(6))/,
    0xB9 => /^(ISO-8859-(6))/,
    0xBA => /^(ISO-8859-(6))/,
    0xBC => /^(ISO-8859-(6))/,
    0xBD => /^(ISO-8859-(6))/,
    0xBE => /^(ISO-8859-(3|6))/,
    0xBF => /^(ISO-8859-(8))/,

    0xC0 => /^(ISO-8859-(6|8))/,
    0xC1 => /^(ISO-8859-(8))/,
    0xC2 => /^(ISO-8859-(8))/,
    0xC3 => /^(ISO-8859-(3|8))/,
    0xC4 => /^(ISO-8859-(8))/,
    0xC5 => /^(ISO-8859-(8))/,
    0xC6 => /^(ISO-8859-(8))/,
    0xC7 => /^(ISO-8859-(8))/,
    0xC8 => /^(ISO-8859-(8))/,
    0xC9 => /^(ISO-8859-(8))/,
    0xCA => /^(ISO-8859-(8))/,
    0xCB => /^(ISO-8859-(8))/,
    0xCC => /^(ISO-8859-(8))/,
    0xCD => /^(ISO-8859-(8))/,
    0xCE => /^(ISO-8859-(8))/,
    0xCF => /^(ISO-8859-(8))/,

    0xD0 => /^(ISO-8859-(3|8))/,
    0xD1 => /^(ISO-8859-(8))/,
    0xD2 => /^(ISO-8859-(7|8)|Windows-(1253))/,
    0xD3 => /^(ISO-8859-(8))/,
    0xD4 => /^(ISO-8859-(8))/,
    0xD5 => /^(ISO-8859-(8)|IBM857)/, # IBM857: Ruby does not support euro sign
    0xD6 => /^(ISO-8859-(8))/,
    0xD7 => /^(ISO-8859-(8))/,
    0xD8 => /^(ISO-8859-(8))/,
    0xD9 => /^(ISO-8859-(8)|Windows-(1255))/,
    0xDA => /^(ISO-8859-(8)|Windows-(1255))/,
    0xDB => /^(ISO-8859-(6|8|11)|Windows-(1255))/,
    0xDC => /^(ISO-8859-(6|8|11)|Windows-(1255))/,
    0xDD => /^(ISO-8859-(6|8|11)|Windows-(1255))/,
    0xDE => /^(ISO-8859-(6|8|11)|Windows-(1255))/,
    0xDF => /^(ISO-8859-(6)|Windows-(1255))/,

    0xE3 => /^(ISO-8859-(3))/,
    0xE7 => /^(IBM857)/,

    0xF0 => /^(ISO-8859-(3))/,
    0xF2 => /^(IBM857)/,
    0xF3 => /^(ISO-8859-(6))/,
    0xF4 => /^(ISO-8859-(6))/,
    0xF5 => /^(ISO-8859-(6))/,
    0xF6 => /^(ISO-8859-(6))/,
    0xF7 => /^(ISO-8859-(6))/,
    0xF8 => /^(ISO-8859-(6))/,
    0xF9 => /^(ISO-8859-(6))/,
    0xFA => /^(ISO-8859-(6))/,
    0xFB => /^(ISO-8859-(6|8)|Windows-(1255))/,
    0xFC => /^(ISO-8859-(6|8|11)|Windows-(1255))/,
    0xFD => /^(ISO-8859-(6|11))/,
    0xFE => /^(ISO-8859-(6|11))/,
    0xFF => /^(ISO-8859-(6|7|8|11)|Windows-(1253|1255)|IBM864)/,
  }.freeze

  BLANKS = [
    0x9,
    0x20,
  ].freeze

  SEPARATORS = [
    0xA,
    0xB,
    0xC,
    0xD,
  ].freeze

  EXTRA_BLANKS = {
    0xA0 => /^(ISO-8859-|Windows-125)/,
    0xAD => /^(ISO-8859-(?!11)|Windows-125)/,
    0x9D => /^Windows-(1256)/,
    0x9E => /^Windows-(1256)/,
    0xF0 => /^(IBM(?!437|737|86)|IBM869|CP)/,
    0xFF => /^(IBM(?!864)|CP)/,
  }.freeze

  def initialize(char)
    super
    @ord = char.ord
  end

  def encoding_has_c0?
    # !!(HAS_C0 =~ @encoding_name)
    true
  end

  def encoding_has_delete?
    # !!(HAS_C0 =~ @encoding_name)
    true
  end

  def encoding_has_c1?
    !!(HAS_C1 =~ @encoding_name)
  end

  def assigned?
    control? || UNASSIGNED[@ord] !~ @encoding_name
  end

  def control?
    c0? || c1? || delete?
  end

  def c0?
    @ord < 0x20 && encoding_has_c0?
  end

  def c1?
    @ord >= 0x80 && @ord < 0xA0 && encoding_has_c1?
  end

  def delete?
    @ord == 0x7F && encoding_has_delete?
  end

  def blank?
    BLANKS.include?(@ord) ||
    SEPARATORS.include?(@ord) ||
    EXTRA_BLANKS[@ord] =~ @encoding_name
  end
end