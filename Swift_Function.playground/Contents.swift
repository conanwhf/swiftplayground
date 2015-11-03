//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, my Functions"
var arr:[Int]=[]
/*************************************/

func simple(n:Int, st:String)->Int{
    st+": \(n)"
    return 0
}

func noArg()->NSDate{
    return NSDate()
}

//———!!!
//These 3 way is the same, and Void means a empty trupe
//func noReturn(n:Int)->Void {
//func noReturn(n:Int)->() {
func noReturn(n:Int) {
    print(n)
}

func find(a: Array<Int>)->(_:Int, _:Int)? {
    
    //if a.count==0 {
    if a.isEmpty {
        return nil
    }
    
    var mi=a[0], ma=a[0]
    for i in a[1...a.count-1]{
        mi = min(mi, i)
        ma = max(ma, i)
    }
    return (mi, ma)
}

//———!!!
//Different ways to define the args
//[nickname] [name]/_:type [=default]
func nickname(n:Int, name internalname:String = "Conan", boy sex:Bool)->String{
    return "No.\(n), \(internalname) is a " + (sex ? "boy":"girl")
}

//simple(999, str)
//noArg()
noReturn(100)
find(arr)
for i in 0...20 {
    arr.append( Int(arc4random()%100))
}
arr
find(arr)
//nickname(10, name: "HY", boy:true)
nickname(1, boy: false)


/*************************************/
func argtest(a: Int ...)-> Int {
    var res=0
    for i in a{
        res += i
    }
    return res
}

func argChange(a:Int, var b:Int, inout c:Int){
    //++a //WRONG!!
    ++b
    ++c
}

argtest()
argtest(-11, 20, 3, 4)
//argtest(arr)    //WRONG

var a=0, b=0, c=0
argChange(a, b, &c)
print("(0, 0, 0) -> (\(a), \(b), \(c))")

/*************************************/
//———!!!
//Function can be a var
let argChange2 = argChange
let argChange3:(Int, Int, inout Int) ->() = argChange
argChange2(a, b, &c)
argChange3(a, b, &c)
print("(0, 0, 0) -> (\(a), \(b), \(c))")



func op1(a:Int, b:Int)->Int{return a+b }
func op2(a:Int, b:Int)->Int{return a-b }
func op3(a:Int, b:Int)->Int{return b-a }
func result(a:Int, b:Int, op:(Int, Int)->Int, name:String)->String{
    return "function \(name) = \(op(a,b))"
}
result(10, 6, op1, "+")
result(10, 6, op2, "-")
result(10, 6, op3, "--")


NSLog("abc %d", 123)
