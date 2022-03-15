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
//Set 2 pointers to iterate through structure and compare values

//Ex: find unique values in a (sorted) array
func findUniqueValues(_ array: [Int]) -> Int {
    if array.count == 0 { return 0 }
    
    var unique: Int = 1
    
    var p1: Int = 0
    var p2: Int = p1 + 1
    
    while p2 < array.count {
        if array[p1] == array[p2] {
            p2 += 1
        } else {
            p1 = p2
            unique += 1
        }
    }
    
    return unique
}

print("Find unique values:")
print(findUniqueValues([4,4,4,4])) //2
print(findUniqueValues([-1,-2,-3,-4])) //4
print(findUniqueValues([-4,-4,-4,-4,1,1,1,1,5,6,7,7,7,11,11])) //6
print(findUniqueValues([])) //0
print("")

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

//Ex. Array - array of ints where each int is between 1 and n (inclusive)
//prove that at least one duplicate number exist
//assume there is only one duplicate; find and return it's value
//must not modify array, space = O(1), runtime must be less that O(n^2)

func findDuplicate(_ array: [Int]) -> Int {
    
    var t: Int = array[0]
    var h: Int = array[0]

    repeat {
        t = array[t]
        h = array[array[h]]
    } while t != h
    
    h = array[0]
    
    while t != h {
        t = array[t]
        h = array[h]
    }
        
    return h
}

print("")
print("Find duplicates:")
print(findDuplicate([1,3,4,2,2])) //2
print(findDuplicate([3,1,3,4,2])) //3
print(findDuplicate([3,1,8,4,7,1,5,6,2])) //8

//Ex. Linked list - search for loop (memory leak)
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

// * -------------------- *

//MARK: Merge Intervals
//Six possibilities:
//            --------------- Time ------------->
//
// 1. (  a  )[b]  --> [a and b don't overlap]           2. [  b  ](a) --> [b and a don't overlap]
// 3. (  a [b] )  --> [a completely overlaps b]         4. [  b (a) ] --> [b completely overlaps a]
// 5. ( a [) b ]  --> [a/b overlap, b ends after a]     5. [ b (] a ) --> [a/b overlap, a ends after b]
//


//Ex. [NON-OVERLAPPING] given an array of (nested) intervals, return an array (nested )of non-overlapping intervals that cover all intervals in the input.
//if input = [1,3],[2,6],[8,10],[15,18], then [1,3] and [2,6] overlap (2,3)
//and can be merged
//Note: arrays are sorted!

func mergeOverlapping(_ intervals: [[Int]]) -> [[Int]] {
    if intervals.isEmpty { return [] }
    
    //if sorting is not guaranteed, first sort arrays
    let sorted = intervals.sorted { $0[0] < $1[0] }
    
    //create return of first sorted array
    var result = [sorted.first!]
    
    //since result takes 1st subarray, start from index 1
    for i in 1..<sorted.count {
        let previousStart = result.last![0]
        let previousEnd = result.last![1]
        
        let currentStart = sorted[i][0]
        let currentEnd = sorted[i][1]
     
        //compare and combine
        if previousEnd >= currentStart && previousEnd < currentEnd {
            result.removeLast()
            result.append([previousStart, currentEnd])
        } else if previousEnd < currentStart {
            result.append([currentStart, currentEnd])
        }
    }
    return result
}

print("Overlapping intervals:")
print(mergeOverlapping([[1,3],[2,6],[8,10],[12,18]]))
print(mergeOverlapping([[1,4],[4,5]]))
print(mergeOverlapping([[1,3],[2,6],[8,10],[9,18]]))

//MARK: Cyclic Sort
//TODO: Come back to this; seems inefficient


//MARK: In-Place Reversal of Linked List

//Ex. reverse the direction of linked list nodes without adding any space complexity
func reverseList(head: Node?) -> Node? {
    
    var current = head
    var previous: Node?
    var next: Node?
    
    while current != nil {
        next = current?.next
        current?.next = previous
        previous = current
        current = next
    }
    
    return previous
}

//print out linked list
func printList(head: Node?) {
    var currentNode = head
    while currentNode != nil {
        print(currentNode?.data ?? -1)
        currentNode = currentNode?.next
    }
}

let reverseNode4 = Node(4)
let reverseNode3 = Node(3)
let reverseNode2 = Node(2)
let reverseNode1 = Node(1)

reverseNode1.next = reverseNode2
reverseNode2.next = reverseNode3
reverseNode3.next = reverseNode4
reverseNode4.next = nil

let myReversedList = reverseList(head: reverseNode1)

print("")
print("Linked list nodes to reverse:")
printList(head: reverseNode1)
print("")
printList(head: myReversedList)

//MARK: Binary Tree Search
//TODO: Come back to this with previous algos


//MARK: Two Heaps
//TODO: Come back to this after seeing leetcode solutions
// unsorted array = | 26 | 12 | 21 | 9 | 8 | 18 | 2 | 6 | 5 |
//1. swap first and last elements: --> | 5 | 12 | 21 | 9 | 8 | 18 | 2 | 6 | 26 | --> n-1 is now out of heap
//2. shift first element down until it reaches correct spot, largest elements will naturally fall to back, shrinking the heap size
//
//Ex.


