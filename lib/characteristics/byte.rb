class ByteCharacteristics < Characteristics
  HAS_C1 = /^(ISO-8859-)/

  UNASSIGNED = {
    0x81 => /^Windows-(1250|1252|1253|1254|1255|1257|1258)/,
    0x83 => /^Windows-(1250|1257)/,
    0x88 => /^Windows-(1250|1253|1257)/,
    0x8A => /^Windows-(1253|1255|1257|1258)/,
    0x8C => /^Windows-(1253|1255|1257)/,
    0x8D => /^Windows-(1252|1253|1254|1255|1258)/,
    0x8E => /^Windows-(1253|1254|1255|1258)/,
    0x8F => /^Windows-(1252|1253|1254|1255|1258)/,

    0x90 => /^Windows-(1250|1252|1253|1254|1255|1257|1258)/,
    0x98 => /^Windows-(1250|1251|1253|1257)/,
    0x9A => /^Windows-(1253|1255|1257|1258)/,
    0x9B => /^Windows-(1252)/,
    0x9C => /^Windows-(1253|1255|1257)/,
    0x9D => /^Windows-(1253|1254|1255|1258)/,
    0x9E => /^Windows-(1253|1254|1255|1258)/,
    0x9F => /^Windows-(1253|1255|1257)/,

    0xA1 => /^Windows-(1257)/,
    0xA5 => /^Windows-(1257)/,
    0xAA => /^Windows-(1253)/,

    0xD2 => /^Windows-(1253)/,
    0xD9 => /^Windows-(1255)/,
    0xDA => /^Windows-(1255)/,
    0xDB => /^Windows-(1255)/,
    0xDC => /^Windows-(1255)/,
    0xDD => /^Windows-(1255)/,
    0xDE => /^Windows-(1255)/,
    0xDF => /^Windows-(1255)/,

    0xFB => /^Windows-(1255)/,
    0xFC => /^Windows-(1255)/,
    0xFF => /^Windows-(1253|1255)/,
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
    0xA0 => /^(ISO-8859-|Windows-)/,
    0x9D => /^Windows-(1256)/,
    0x9F => /^Windows-(1256)/,
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