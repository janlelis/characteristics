# frozen_string_literal: true

class AsciiCharacteristics < Characteristics
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
    super
    @ord = char.ord if @is_valid
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
    @is_valid && @ord < 0x20
  end

  def delete?
    @is_valid && @ord == 0x7F
  end

  def c1?
    false
  end

  def blank?
    @is_valid && ( BLANKS.include?(@ord) || SEPARATORS.include?(@ord) )
  end

  def format?
    false
  end
end