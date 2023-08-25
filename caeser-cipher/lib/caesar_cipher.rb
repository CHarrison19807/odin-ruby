
class CaesarCipher
    def caesar_cipher(string, shift)
        result = ""
        string.each_char do |character|
            lowest_ascii_val = character.ord < 91 ? 65 : 97
            if character.ord.between?(65, 90) || character.ord.between?(97, 122)
                new_char = (((character.ord - lowest_ascii_val) + shift) % 26) + lowest_ascii_val
                result += new_char.chr
            else
                result += character
            end
        end
        result
    end
end
