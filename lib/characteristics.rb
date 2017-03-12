require_relative "characteristics/version"

require_relative "characteristics/ascii"
require_relative "characteristics/binary"
require_relative "characteristics/byte"
require_relative "characteristics/unicode"

class Characteristics
  def self.type_from_encoding_name(encoding_name)
    case encoding_name
    when "US-ASCII"
      :ascii
    when "ASCII-8BIT"
      :binary
    when /^UTF-/
      :unicode
    when /^ISO-8859-/, /^Windows/
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
    @is_valid = char.valid_encoding?
    @encoding = char.encoding
    @encoding_name = @encoding.name
  end

  def valid?
    @is_valid
  end

  def unicode?
    false
  end

  def assigned?
  end

  def control?
  end

  def blank?
  end
end
