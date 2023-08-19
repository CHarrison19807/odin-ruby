def stock_picker(day_array)

    days = Array.new(2)
    max_profit = 0
    day_array.each_with_index do |buy, buy_index|
        
        day_array.each_with_index do |sell, sell_index|

            profit = sell - buy

            if profit > max_profit && sell_index > buy_index
                max_profit = profit
                days[0] = buy_index
                days[1] = sell_index
            end
        end
    end 
    p days 
    print "For a profit of #{day_array[days[1]]} - #{day_array[days[0]]} = #{max_profit}\n"
end

    
    

stock_picker([17,3,6,9,15,8,6,1,10])
#=> [1,4]   for a profit of $15 - $3 == $12