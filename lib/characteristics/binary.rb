# frozen_string_literal: true

class BinaryCharacteristics < Characteristics
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

  def initialize(char)
    @ord = char.ord
    @encoding = char.encoding
    @encoding_name = @encoding.name
  end

  def valid?
    true
  end

  def unicode?
    false
  end

  def assigned?
    true
  end

  def control?
    c0? || delete?
  end

  def c0?
    @ord < 0x20
  end

  def delete?
    @ord == 0x7F
  end

  def blank?
    BLANKS.include?(@ord) || SEPARATORS.include?(@ord)
  end

  def format?
    false
  end
end