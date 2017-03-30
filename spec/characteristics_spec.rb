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

      # TODO

      # describe "ISO-8859-2" do
      # describe "ISO-8859-3" do
      # describe "ISO-8859-4" do
      # describe "ISO-8859-5" do
      # describe "ISO-8859-6" do
      # describe "ISO-8859-7" do
      # describe "ISO-8859-8" do
      # describe "ISO-8859-9" do
      # describe "ISO-8859-10" do
      # describe "ISO-8859-11" do
      # describe "ISO-8859-13" do
      # describe "ISO-8859-14" do
      # describe "ISO-8859-15" do
      # describe "ISO-8859-16" do
    end

    describe "Windows-125*" do
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

      # TODO

      # describe "Windows-1250" do
      # describe "Windows-1251" do
      # describe "Windows-1253" do
      # describe "Windows-1254" do
      # describe "Windows-1255" do
      # describe "Windows-1256" do
      # describe "Windows-1257" do
      # describe "Windows-1258" do
    end

    describe "IBM*, CP85*" do
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

      # describe "IBM437" do
      # describe "IBM737" do
      # describe "IBM775" do
      # describe "CP850" do
      # describe "IBM852" do
      # describe "CP852" do
      # describe "IBM855" do
      # describe "CP855" do
      # describe "IBM857" do
      # describe "IBM860" do
      # describe "IBM861" do
      # describe "IBM862" do
      # describe "IBM863" do
      # describe "IBM864" do
      # describe "IBM865" do
      # describe "IBM866" do
    end

    describe "mac*" do
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

      # describe "macCentEuro" do
      # describe "macCroatian" do
      # describe "macCyrillic" do
      # describe "macGreek" do
      # describe "macIceland" do
      # describe "macRomania" do
      # describe "macThai" do
      # describe "macTurkish" do
      # describe "macUkraine" do
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
