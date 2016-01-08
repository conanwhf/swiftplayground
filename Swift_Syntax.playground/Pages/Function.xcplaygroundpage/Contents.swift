//: Playground - noun: a place where people can play

import UIKit

var str                                       = "Hello, my Functions"

/*************************************/
 /**
 <#Description#>
 */
func base_demo() {
    var arr:[Int]=[]
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
        var mi = a[0], ma = a[0]
        for i in a[1...a.count-1] {
            mi     = min(mi, i)
            ma     = max(ma, i)
        }
        return (mi, ma)
    }

    simple(999, st: str)
    noArg()
    noReturn(100)
    find(arr)
    for _ in 0...20 {
        arr.append( Int(arc4random()%100))
    }
    arr
    find(arr)
}




/*************************************/
/**
 Parameter demo
 */
func parameter_demo(){

    //———!!!
    //Different ways to define the args
    //[nickname] [name]/_:type [=default]
    func nickname(n:Int, name internalname:String = "Conan", boy sex:Bool)->String{
        return "No.\(n), \(internalname) is a " + (sex ? "boy":"girl")
    }

    nickname(10, name: "HY", boy:true)
    nickname(32, boy: false)


    func argtest(a: Int ...)-> Int {
        var res    = 0
        for i in a {
            res  += i
        }
        return res
    }

    func argChange(a:Int, var b:Int, inout c:Int){
        //++a //WRONG!!
        --b
        ++c
    }

    argtest()
    argtest(-11, 20, 3, 4)
    //argtest(arr)    //WRONG

    var a = 0, b=11, c=222
    argChange(a, b: b, c: &c)
    print("(0, 11, 222) -> (\(a), \(b), \(c))")
}



/*************************************/
 /**
 Funtion Type demo, function can be used as a var
 */
func funtype_demo(){

    func op1(a:Int, b:Int)->Int{return a+b }
    func op2(a:Int, b:Int)->Int{return a-b }
    func op3(a:Int, b:Int)->Int{return b-a }

    let op4                            = op1
    let op5 : (Int, Int ) -> Int  = op1
    op4(1, b:2)
    //op4(1,2)      //WRONG
    op5(1, 2)       //RIGHT

    //Pass function as a var
    func result(a:Int, _ b:Int, _ op:(Int, Int)->Int, _ opName:String)-> String{
        return "function [\(opName)] -> \(op(a,b))"
    }
    result(10, 6, op1, "+")
    result(10, 6, op2, "-")
    result(10, 6, op3, "--")
    result(10, 6, op3, "*(wrong)")

    //use as return value
    func which(st: String) -> (Int, Int)->Int {
        switch st {
        case "+" :  return op1
        case "-" : return op2
        default : return op3
        }
    }
    let myfunction                = which("*")
    myfunction(10, 6)
}


/**
*  this part show the Nested Functions
*/
//base_demo()
//parameter_demo()
//funtype_demo()

let testlog : (AnyObject, AnyObject?) -> () = ({ print(" func: \(__FUNCTION__) in \(__FILE__): \($0), from \($1)")})
testlog(3, "555")
