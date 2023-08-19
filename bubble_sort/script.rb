def bubble_sort(array)

    temp = 0
    sorted = false

    until sorted 

        change = false
        array.each_with_index do |left, left_index|
            array.each_with_index do |right, right_index|

                if left > right && left_index + 1 == right_index
                    temp = array[left_index]
                    array[left_index] = array[right_index]
                    array[right_index] = temp
                    change = true

                end
            end
        end

        unless change
            sorted = true
        end
    end
    p array
    array
end 

bubble_sort([4,3,78,2,0,2])
#=> [0,2,2,3,4,78]