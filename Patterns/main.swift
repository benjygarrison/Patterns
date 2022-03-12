//
//  main.swift
//  Patterns
//
//  Created by Ben Garrison on 3/11/22.
//

import Foundation

//MARK: 1. Sliding Window

//TODO: Create NON-FIXED length example

//create a window spanning a subrange in a linear data structure and "slide" it along structure
//     |------------|
// | 1 | 2 | 4 | -1 | 7 | 10 | 3 |
//     |------------|
//    p1            p2            [ n = 3 ]

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


// * -------------------- *


//MARK: 2. Two Pointers

//TODO: Add better example

// p1 start value = 1, p2 start value = 1
//for loop....
//p1 either becomes value of current index plus previous index (indices), or, if current index is greater, it becomes that
//p2 tracks p1, but if p1 is smaller than p2, p2 rejects p1 value
//------->|   |<-------
//| 1 | 2 | 3 | 4 | 6 |
//    |       |
//   p1       p2      [find two elements that equal 6 (2 + 4)]

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

// * -------------------- *

//MARK: Hare and Tortoise

//TODO: Add array example

// p1 and p2 start value = 1
// p1 increment +2, p2, increment + 1
// if p1 hits loop, it keeps cycling back to loop start; eventually p2 catches up at loop start
// else both elements hit end of structure
//         4
//       /   \
//  1 2 3     5
//      \_____/
//                  [cycle detected at node 3 --> 5 links back to 3]

class Node {
    var data: Int
    weak var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

func hasCycle(first: Node) -> Bool {
    var slow: Node? = first //tortoise
    var fast: Node? = first //hare
    
    while fast != nil && fast!.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow?.data == fast?.data {
            return true
        }
    }
    return false
}

//Arguments and results:

//Args:
//For 1 and 2
let node6 = Node(6)
let node5 = Node(5, node6)
let node4 = Node(4, node5)
let node3 = Node(3, node4)
let node2 = Node(2, node3)
let node1 = Node(1, node2)

let node11 = Node(11, node4)
let node10 = Node(10, node11)

//For 3
let cycleNode5 = Node(5)
let cycleNode4 = Node(4)
let cycleNode3 = Node(3)
let cycleNode2 = Node(2)
let cycleHead = Node(1)

cycleHead.next = cycleNode2
cycleNode2.next = cycleNode3
cycleNode3.next = cycleNode4
cycleNode4.next = cycleNode5
cycleNode5.next = cycleNode3 // <-- set 5 to cycle to 3, create loop

//Results:
print("")
print("Question 4 answer is: \(hasCycle(first: cycleHead))")
print("")
