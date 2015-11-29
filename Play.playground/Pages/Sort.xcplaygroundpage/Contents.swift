//: Playground - noun: a place where people can play

import UIKit

/**
 Binary search function, find the target in a array
 
 - parameter target:    target value you want
 - parameter sortedArr: A sorted array
 
 - returns: return the index if found, otherwise return nil
 */
func binarySearch<T:Comparable> (target:T, _ sortedArr:Array<T>)-> Int? {
    var index = sortedArr.startIndex
    var range = (sortedArr.startIndex, sortedArr.endIndex-1)
    
    repeat {
        index = (range.0 + range.1) / 2
        //print("index=\(index), range=\(range), arr[index]=\(sortedArr[index])")
        
        if sortedArr[index] == target {
            return index
        }
        
        if sortedArr[index] < target {
            range.0 = index + 1
        }
        else {
            range.1 = index - 1
        }
        
    } while range.0 <= range.1
    
    return nil
}




/*******************************************/
 //Customize Sort Test
func mySort1(a:Int, b:Int)->Bool { return a>b }

func mySort2(a:Int, b:Int)->Bool { return a<b }

func mySort3(a:Int, b:Int)->Bool { return abs(a)>abs(b) }

func myStrSort(a:String, _ b:String)->Bool{
    if a.characters.count != b.characters.count {
        return a.characters.count < b.characters.count
    }
    return a<b
}



/*********************************************/
 //New Array by random
func randomInt(start:Int, _ end:Int)-> Int{
    
    let range = abs(end - start) + 1
    let n = Int(arc4random() % UInt32(range))
    
    return n + start
}
var arr:Array<Int> = []
for _ in 0..<10 {
    //arr.append( Int(arc4random()%100) * (i%2==0 ? 1 : -1) )
    arr.append(randomInt(-100, 100))
}


/***********************************************/
//Int sort test
arr
arr.sort(<)
arr.sort(>)
arr.sort(mySort1)
arr.sort(mySort2)
arr.sort(mySort3)
arr = arr.sort(<)
binarySearch(65, arr)

//String Sort Test
var strarr=["fd", "retwq", "fdas", "uuy", "m", "opr", "jioe"]
strarr = strarr.sort()
strarr.sort(myStrSort)
binarySearch("opr", strarr)


