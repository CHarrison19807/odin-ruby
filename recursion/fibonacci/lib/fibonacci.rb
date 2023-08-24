def fibonacci_iterative(number)
    array = Array.new(number)
    i = 0
    while i < number
        if i == 0
            array[i] = 0
        elsif i == 1
            array[i] = 1
        else
            fibonacci = (array[i - 1] + array[i - 2])
            array[i] = fibonacci
        end
        i += 1
    end
    array
end

def fibonacci_recursive(number)
    return [0] if number == 0
    return [0, 1] if number <= 2 && number > 0

    array = fibonacci_recursive(number - 1)
    array.push(array[-1] + array[-2])
end


p fibonacci_iterative(10)
p fibonacci_recursive(10)