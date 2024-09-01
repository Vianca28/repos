def bubble_sort array
 array_length=array.length-1 
n=0

is_to_sort= true
while is_to_sort  do  
    n+=1   
    i=0 
      is_to_sort =false
      while i < array_length && array[n] != nil
         if array[i] > array[n] 
            array[i], array[n] = array[n], array[i]
            is_to_sort= true
         end
      i += 1 
    end    
  end
 p array
 end
 

bubble_sort([4, 3, 78, 2, 0, 2])