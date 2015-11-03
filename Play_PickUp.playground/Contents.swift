//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*************************************/
//binary search


func searchTwo(n:Int)->Int {
    var index = 0
    var range = (0, arr.count-1)

    repeat {
        index = (range.1 + range.0) / 2
        print("index=\(index), range=\(range)")
        if arr[index]==n {
            return index
        }
        
        if arr[index]<n {
            range.0 = index + 1
        }
        else {
            range.1 = index - 1
        }
    } while range.0<range.1
    
    return -1
}

var arr = [43,01,11,19,84,04,03,08,77,10]
arr.sort(<)
let tryit = Int(arc4random()%100)
//searchTwo(try)


/*************************************/
arr=[]
for i in 0...10 {
    arr.append( Int(arc4random()%100) * (i%2==0 ? 1 : -1) )
}
sorted(arr)
func mysort1(a:Int, b:Int)->Bool { return a>b }
func mysort2(a:Int, b:Int)->Bool { return a<b }
func mysort3(a:Int, b:Int)->Bool { return abs(a)>abs(b) }
//sorted(arr,mysort1)
//sorted(arr,mysort2)
//sorted(arr,mysort3)

let strarr=["fd", "retwq", "fdas", "uuy", "m", "opr", "jioe"]
func mysort4(a:String, b:String)->Bool{
    if count(a) != count(b) {
        return count(a) < count(b)
    }
    return a<b
}
sorted(strarr)
sorted(strarr,mysort4)
