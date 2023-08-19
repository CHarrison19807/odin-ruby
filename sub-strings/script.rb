def substrings(string, dictionary)
    result = Hash.new(0)
    dictionary.each do |substring|
        match_count = string.downcase.scan(substring).length
        result[substring] = match_count unless match_count == 0    
        end
    puts result
end
