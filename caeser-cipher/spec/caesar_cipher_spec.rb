#spec/causar_cipher_spec.rb
require './lib/caesar_cipher.rb' 

describe CaesarCipher do
    describe "#caesar_cipher" do

      it "works with small positive shift" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("Aa", 3)).to eql("Dd")
      end

      it "works with small negative shift" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("Aa", -3)).to eql("Xx")
      end

      it "works with large positive shift" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("Aa", 83)).to eql("Ff")
      end

      it "works with large negative shift" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("Aa", -83)).to eql("Vv")
      end

      it "works with a phrase containing punctuation" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("Hello, World!", -10)).to eql("Xubbe, Mehbt!")
      end

      it "works with no shift" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("Hello", 0)).to eql("Hello")
      end

      it "works with a phrase containing numbers" do
        codebreaker = CaesarCipher.new
        expect(codebreaker.caesar_cipher("The year is 2023!", 10)).to eql("Dro iokb sc 2023!")
      end
  end
end