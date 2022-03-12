//
//  main.swift
//  Patterns
//
//  Created by Ben Garrison on 3/11/22.
//

import Foundation

//MARK: 1. Sliding Window
//create a window spanning a subrange in a linear data structure and "slide" it along structure

//Example using consecutive sum of n length
func maxConsecutiveSum(_ array: [Int], _ n: Int) -> Int {
    //guard for array less than n length or negative n
    if array.count < n { return 0 }
    if n < 0 {return 0 }
    
    var maxSum = 0
    
    //sum first n elements (retreive baseline sum for comparison)
    for i in 0..<n {
        maxSum += array[i]
    }
    
    //set pointers
    var p1 = 0 //start at array[0]
    var p2 = n //start at array[n]
    //set comparator for maxSum (equalt to n, based on above for loop)
    var tempSum = maxSum
    
    //loop through array (criteria to stop loop: p2 reaches end of array)
    while p2 < array.count {
        //calculate new sum using window edges (INCLUDE new p2, DROP previous p1)
        tempSum = tempSum - array[p1] + array[p2]
        //update condition (if new sum is bigger, cast tempSum to maxSum)
        if tempSum > maxSum {
            maxSum = tempSum
        }
        //slide window along list
        p1+=1
        p2+=1
    }
    return maxSum
} //That's it!!

print(maxConsecutiveSum([1,2,3,4,5], 3))
print(maxConsecutiveSum([1,9,9,9,9,-9,1], -1))
print(maxConsecutiveSum([1,20,9,-9,1,1,100], 2))
print(maxConsecutiveSum([1,1,1,2,1,2,1,1,4,1,5,1], 6))
print(maxConsecutiveSum([], 1))

//MARK: 2. Two Pointers

