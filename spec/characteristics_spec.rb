require_relative "../lib/characteristics"
require "minitest/autorun"

describe Characteristics do
  def valid?(char)
    Characteristics.create(char.force_encoding(encoding)).valid?
  end

  def assigned?(char)
    Characteristics.create(char.force_encoding(encoding)).assigned?
  end

  def control?(char)
    Characteristics.create(char.force_encoding(encoding)).control?
  end

  def blank?(char)
    Characteristics.create(char.force_encoding(encoding)).blank?
  end

  def separator?(char)
    Characteristics.create(char.force_encoding(encoding)).separator?
  end

  def format?(char)
    Characteristics.create(char.force_encoding(encoding)).format?
  end

  def bidi_control?(char)
    Characteristics.create(char.force_encoding(encoding)).bidi_control?
  end

  describe UnicodeCharacteristics do
    describe "UTF*" do
      let(:encoding) { "UTF-8" }

      it "is valid or not" do
        assert valid? "\x21"
        refute valid? "\x80"
      end

      it "is assigned or not" do
        assert assigned? "\x21"
        refute assigned? "\uFFEF"
      end

      it "is control or not" do
        assert control? "\x1E"
        assert control? "\x7F"
        assert control? "\u0080"
        refute control? "\x67"
      end

      it "is blank or not" do
        assert blank? "\x20"
        refute blank? "\x21"
      end

      it "is separator or not" do
        assert separator? "\n"
        refute separator? "\x20"
      end

      it "is format or not" do
        assert format? "\uFFF9"
        refute format? "\x21"
      end

      it "is bidi_control or not" do
        assert bidi_control? "\u202D"
        refute bidi_control? "\x21"
      end
    end

    describe "Japanese Emojis" do
      it "can be a KDDI emoji" do
        encoding = "UTF8-KDDI"
        assert Characteristics.create("\uE468".force_encoding(encoding)).kddi?
        refute Characteristics.create("A".force_encoding(encoding)).kddi?
      end

      it "can be a SoftBank emoji" do
        encoding = "UTF8-SoftBank"
        assert Characteristics.create("\uE001".force_encoding(encoding)).softbank?
        refute Characteristics.create("A".force_encoding(encoding)).softbank?
      end

      it "can be a DoCoMo emoji" do
        encoding = "UTF8-DoCoMo"
        assert Characteristics.create("\uE63E".force_encoding(encoding)).docomo?
        refute Characteristics.create("A".force_encoding(encoding)).docomo?
      end
    end
  end

  describe BinaryCharacteristics do
    describe "ASCII-8BIT" do
      let(:encoding) { "ASCII-8BIT" }

      it "is always valid" do
        assert valid? "\x80"
      end

      it "is always assigned" do
        assert assigned? "\x7F"
      end

      it "is control or not" do
        assert control? "\x1E"
        assert control? "\x7F"
        refute control? "\x67"
      end

      it "is blank or not" do
        assert blank? "\x20"
        refute blank? "\x21"
      end

      it "is separator or not" do
        assert separator? "\n"
        refute separator? "\x20"
      end

      it "is never format" do
        refute format? "\x21"
      end

      it "is never bidi_control" do
        refute bidi_control? "\x21"
      end
    end
  end

  describe AsciiCharacteristics do
    describe "US-ASCII" do
      let(:encoding) { "US-ASCII" }

      it "is valid or not" do
        assert valid? "\x21"
        refute valid? "\x80"
      end

      it "is always assigned" do
        assert assigned? "\x21"
      end

      it "is control or not" do
        assert control? "\x1E"
        assert control? "\x7F"
        refute control? "\x67"
      end

      it "is blank or not" do
        assert blank? "\x20"
        refute blank? "\x21"
      end

      it "is separator or not" do
        assert separator? "\n"
        refute separator? "\x20"
      end

      it "is never format" do
        refute format? "\x21"
      end

      it "is never bidi_control" do
        refute bidi_control? "\x21"
      end
    end
  end

  describe ByteCharacteristics do
    describe "ISO-8859-*" do
      describe "ISO-8859-1" do
        let(:encoding) { "ISO-8859-1" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-2" do
        let(:encoding) { "ISO-8859-2" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-3" do
        let(:encoding) { "ISO-8859-3" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xA5"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-4" do
        let(:encoding) { "ISO-8859-4" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-5" do
        let(:encoding) { "ISO-8859-5" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-6" do
        let(:encoding) { "ISO-8859-6" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xA1"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-7" do
        let(:encoding) { "ISO-8859-7" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xFF"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-8" do
        let(:encoding) { "ISO-8859-8" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xA1"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is format or not" do
          assert format? "\xFE"
          refute format? "\x21"
        end

        it "is bidi_control or not" do
          assert bidi_control? "\xFE"
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-9" do
        let(:encoding) { "ISO-8859-9" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-10" do
        let(:encoding) { "ISO-8859-10" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-11" do
        let(:encoding) { "ISO-8859-11" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xDB"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-13" do
        let(:encoding) { "ISO-8859-13" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-14" do
        let(:encoding) { "ISO-8859-14" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-15" do
        let(:encoding) { "ISO-8859-15" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "ISO-8859-16" do
        let(:encoding) { "ISO-8859-16" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
          assert assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          assert control? "\x7F"
          assert control? "\x80"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end
    end

    describe "Windows-125*" do
      describe "Windows-1250" do
        let(:encoding) { "Windows-1250" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1251" do
        let(:encoding) { "Windows-1251" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x98"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1252" do
        let(:encoding) { "Windows-1252" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1253" do
        let(:encoding) { "Windows-1253" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1254" do
        let(:encoding) { "Windows-1254" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1255" do
        let(:encoding) { "Windows-1255" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is format or not" do
          assert format? "\xFE"
          refute format? "\x21"
        end

        it "is never bidi_control" do
          assert bidi_control? "\xFE"
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1256" do
        let(:encoding) { "Windows-1256" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is format or not" do
          assert format? "\xFE"
          refute format? "\x21"
        end

        it "is never bidi_control" do
          assert bidi_control? "\xFE"
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1257" do
        let(:encoding) { "Windows-1257" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-1258" do
        let(:encoding) { "Windows-1258" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x81"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end
    end

    describe "IBM*, CP85*" do
      describe "IBM437" do
        let(:encoding) { "IBM437" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM737" do
        let(:encoding) { "IBM737" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM775" do
        let(:encoding) { "IBM775" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "CP850" do
        let(:encoding) { "CP850" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM852" do
        let(:encoding) { "IBM852" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "CP852" do
        let(:encoding) { "CP852" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM855" do
        let(:encoding) { "IBM855" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "CP855" do
        let(:encoding) { "CP855" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM857" do
        let(:encoding) { "IBM857" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xE7"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM860" do
        let(:encoding) { "IBM860" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM861" do
        let(:encoding) { "IBM861" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM862" do
        let(:encoding) { "IBM862" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM863" do
        let(:encoding) { "IBM863" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM864" do
        let(:encoding) { "IBM864" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xA6"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM865" do
        let(:encoding) { "IBM865" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM866" do
        let(:encoding) { "IBM866" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "IBM869" do
        let(:encoding) { "IBM869" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\x80"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end
    end

    describe "mac*" do
      describe "macCentEuro" do
        let(:encoding) { "macCentEuro" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macCroatian" do
        let(:encoding) { "macCroatian" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macCyrillic" do
        let(:encoding) { "macCyrillic" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macGreek" do
        let(:encoding) { "macGreek" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macIceland" do
        let(:encoding) { "macIceland" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macRoman" do
        let(:encoding) { "macRoman" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macRomania" do
        let(:encoding) { "macRomania" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macThai" do
        let(:encoding) { "macThai" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xFC"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macTurkish" do
        let(:encoding) { "macTurkish" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xF5"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "macUkraine" do
        let(:encoding) { "macUkraine" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

    end

    describe "TIS-620/Windows-874" do
      describe "TIS-620" do
        let(:encoding) { "TIS-620" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\x21"
          refute assigned? "\xA0"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "Windows-874" do
        let(:encoding) { "Windows-874" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is assigned or not" do
          assert assigned? "\xA0"
          refute assigned? "\x99"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end
    end

    describe "KOI8-*" do
      describe "KOI8-R" do
        let(:encoding) { "KOI8-R" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end

      describe "KOI8-U" do
        let(:encoding) { "KOI8-U" }

        it "is always valid" do
          assert valid? "\x80"
        end

        it "is always assigned" do
          assert assigned? "\x21"
        end

        it "is control or not" do
          assert control? "\x1E"
          refute control? "\x67"
        end

        it "is blank or not" do
          assert blank? "\x20"
          refute blank? "\x21"
        end

        it "is separator or not" do
          assert separator? "\n"
          refute separator? "\x20"
        end

        it "is never format" do
          refute format? "\x21"
        end

        it "is never bidi_control" do
          refute bidi_control? "\x21"
        end
      end
    end
  end
end
