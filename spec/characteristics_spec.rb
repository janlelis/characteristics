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

  describe UnicodeCharacteristics do
    describe "UTF-*" do
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
  end
end
