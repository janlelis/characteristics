# frozen_string_literal: true

require_relative "characteristics/version"

require_relative "characteristics/ascii"
require_relative "characteristics/binary"
require_relative "characteristics/byte"
require_relative "characteristics/unicode"

class Characteristics
  def self.type_from_encoding_name(encoding_name)
    case encoding_name
    when "US-ASCII", "GB1988"
      :ascii
    when "ASCII-8BIT"
      :binary
    when /^UTF-?/
      :unicode
    when /^ISO-8859-/, /^Windows-125/, /^(IBM|CP85)/, /^mac/, 'TIS-620', 'Windows-874', /^KOI8-/
      :byte
    else
      raise ArgumentError, "encoding <#{encoding_name}> not supported"
    end
  end

  def self.create_for_type(char, type)
    case type
    when :unicode
      UnicodeCharacteristics.new(char)
    when :byte
      ByteCharacteristics.new(char)
    when :ascii
      AsciiCharacteristics.new(char)
    else
      BinaryCharacteristics.new(char)
    end
  end

  def self.create(char)
    create_for_type(char, type_from_encoding_name(char.encoding.name))
  end

  attr_reader :encoding

  def initialize(char)
    raise ArgumentError, "Do not use abstract Characteristics.new(char) directly, please use Characteristics.create(char)" if self.class == Characteristics

    @is_valid = char.valid_encoding?
    @encoding = char.encoding
    @encoding_name = @encoding.name
  end

  def valid?
    @is_valid
  end

  def unicode?
  end

  def assigned?
  end

  def control?
  end

  def c0?
  end

  def delete?
  end

  def c1?
  end

  def blank?
  end

  def format?
  end

  def bidi_control?
  end

  # private use emojis
  def kddi?
  end

  # private use emojis
  def softbank?
  end

  # private use emojis
  def docomo?
  end

  private

  def encoding_has_kddi?
    @encoding_name.end_with? "KDDI"
  end

  def encoding_has_softbank?
    @encoding_name.end_with? "SoftBank"
  end

  def encoding_has_docomo?
    @encoding_name.end_with? "DoCoMo"
  end

  def encoding_has_c0?
    true
  end

  def encoding_has_delete?
    true
  end

  def encoding_has_c1?
    false
  end
end
