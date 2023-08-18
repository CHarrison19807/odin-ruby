def caesar_cipher(string, shift)
    result = ""
    index = 0
    string_array = string.split("")
    string_array.each do |character|
        ascii_value = character.ord        

        if ascii_value.between?(65, 90) && 

            if ascii_value + shift > 90

                ascii_value += shift - 26 
            else

                ascii_value += shift
            end
        elsif ascii_value.between?(97, 122)

            if ascii_value + shift > 122

                ascii_value += shift - 26 
            else
                
                ascii_value += shift
            end
        end

        result.concat(ascii_value.chr)
    end
    puts result
end

caesar_cipher("What a string!", 5)