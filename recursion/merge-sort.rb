def merge_sort(array)
    return array if array.length < 2

    mid_point = array.length / 2
    
    left_part = merge_sort(array[0...mid_point])
    right_part = merge_sort(array[mid_point..array.length])

    sorted = []

    until left_part.empty? || right_part.empty?
        if left_part[0] >= right_part[0]
            sorted.push(right_part.shift) 
        else    
            sorted.push(left_part.shift)
        end
    end

    sorted + left_part + right_part
end

p merge_sort([34, 4, 2, 1, 3, 4, 6, 8, 9, 10, 112, 3321, 343, 546, 34, 231])