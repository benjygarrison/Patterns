//
//  main.swift
//  Patterns
//
//  Created by Ben Garrison on 3/11/22.
//

import Foundation

func maxConsecutiveSum(_ array: [Int], _ n: Int) -> Int {
    //guard for array less than n length
    if array.count < n { return 0 }
    
    var maxSum = 0
    
    //sum first n elements (capture elements amounting to n places)
    for i in 0..<n {
        maxSum += array[i]
    }
    
    //set pointers
    var p1 = 0 //start at array[0]
    var p2 = n //start at array[n]
    var tempSum = maxSum // should equal n, based on above for loop
    
    //criteria to stop: p2 reaches end of array
    while p2 < array.count {
        //calculate sum using window edges (INCLUDING p2, EXCLUDING p1)
        //tempSum =
        tempSum = tempSum - array[p1] + array[p2]
        //update condition
        if tempSum > maxSum {
            maxSum = tempSum
        }
        //slide window along list
        p1+=1
        p2+=1
    }
    return maxSum
}


print(maxConsecutiveSum([1,2,3,4,5], 3))
print(maxConsecutiveSum([1,9,9,9,9,-9,1], 5))
print(maxConsecutiveSum([1,20,9,-9,1,1,100], 2))
print(maxConsecutiveSum([1,1,1,2,1,2,1,1,4,1,5,1], 6))



