//
//  main.swift
//  Patterns
//
//  Created by Ben Garrison on 3/11/22.
//

import Foundation

//MARK: 1. Sliding Window
//create a window spanning a subrange in a linear data structure and "slide" it along structure

//Example using consecutive sum of n length --> FIXED LENGTH
func maxConsecutiveSum(_ array: [Int], _ n: Int) -> Int {
    //guard for array less than n length or negative n
    if array.count < n { return 0 }
    if n < 0 {return 0 }
    
    var maxSum = 0
    
    //sum first n elements (retrieve baseline sum for comparison)
    for i in 0..<n {
        maxSum += array[i]
    }
    
    //set pointers
    var p1 = 0 //start at array[0]
    var p2 = n //start at array[n]
    //set comparator for maxSum (equal to n, based on above for loop)
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
print(maxConsecutiveSum([1,9,9,9,9,-9,1], 3))
print(maxConsecutiveSum([1,20,9,-9,1,1,100], 4))
print(maxConsecutiveSum([1,1,1,2,1,2,1,1,4,1,5,1], 6))
print(maxConsecutiveSum([], 1))

//MARK: 2. Two Pointers

// p1 start value = 1, p2 start value = 1
//for loop....
//p1 either becomes value of current index plus previous index (indices), or, if current index is greater, it becomes that
//p2 tracks p1, but if p1 is smaller than p2, p2 rejects p1 value
//
//
//[1,-2,3,4,-5]

func maxConsecutiveSumNotFixed(_ array: [Int]) -> Int {
    //set pointers, start from array 0
    var p1 = array[0]
    var p2 = array[0]
    
    //loop through until p1 hits end of array
    for i in 1..<array.count {
        //keep adding values to p1,until you hit a value whose neg value exceeds current pos value i.e. 3,3,3 = 9 but -10 inversely greater
        p1 = max(p1 + array[i], array[i])
        //p2 tracks p1, contains whichever value is greater
        p2 = max(p1, p2)
    }
    return p2
}

print(maxConsecutiveSumNotFixed([1,-1,3,-2,4,5,-10]))
print(maxConsecutiveSumNotFixed([2,1,-10,1,11]))


