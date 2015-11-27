//: Playground - noun: a place where people can play

import UIKit

func base(){

    /*************************************/
    var str                        = "Hello, playground\n"
    let n                          = 100
    var myfloat:Float, Myfloat     = 0.1+Float(n)
    typealias  Length              = UInt8
    var temp:Length                = 8

    myfloat                        = Float(n)
    myfloat                        = 1.832019321
    myfloat.description
    temp++

    print("n=\(n), myfloat=\(myfloat) \(Myfloat), temp=\(temp), "+str)
    //———!!!
    //myfloat can not convert to string by String()
    str="test string \(myfloat)  or another way:"+String(Int(myfloat))
    myfloat.distanceTo(2.7)

    /*************************************/
    let tuple1                     = (alive:true, mon:11, day:04, year:1984)
    //———!!!
    //the type hard define cannot use if define tuple unit name
    let tuple2/*:(String, Double, Bool)*/ = (a:"2333", b:4.5, c:false)
    let tuple3                     = [(Int, String)](count:3, repeatedValue:(0xE,"test"))
    tuple1.0
    tuple1.day
    tuple3

    let (_,_,pick,_)=tuple1; pick
    print("\(tuple2)")
    let (x,y,z)                    = (0,1,false)
    print("\(x), \(y), \(z)")

    /*************************************/
    str                            = tuple2.a

    var opt:Int?=nil
    opt                            = Int(str)
    //var opt=str.toInt()
    print("\(opt), \(opt!)")

    str                            = String(n)
    let notsure                    = String(n)
    //var notsure:String? = String(n)
    print(notsure)

    var opt2:Int!=Int(str)
    opt2                           = nil
    print("\(opt2)")
}


func flow(){

    /*************************************/
    var opt                        = Int("12")
    //———!!!
    //assert = if false then print&break
    assert(opt != nil, "oh error here")
    print("ah~~ Come here? opt=\(++(opt!))")

    /*************************************/
    for _ in 0...99 {}
    for _ in 0..<100 {}

    var n                          = 0
    for j in 0...10 {
        if j==3 {continue}
        if j==8 {break}
        //———!!!
        //the cal += cannot return anything, but it's runalbe
    debugPrint("j=\(j), return=\(n += j), n=\(n)")
    }

    /*************************************/
    for var i                      = 0; i<5; i++  {}
    for var i                      = 0; i<5; {i++}
    //———!!!
    //in for-in loop, you can't change the index, even it's defined as var
    var i                          = 0
    for i in 1...10{
        //i = i+0       WRONG!!!
    }
    //But this way is OK
    for i                          = 0; i < 10; i++ {
    i                              = i+1//OK!!!
    }

    /*************************************/
    i                              = 10
    while i>0 {i--}
    i                              = 10
    repeat {i--} while i>0

    /*************************************/
    if  i<0 {
        print("A")
    }
    else if i>0 { print("B")
    }
    else {print("C")}

    if i<0 {
        print("A")
    }
    else {
        if i>0{
            print("B")
        }
        else {print("C")}
    }

    /*************************************/
    switch i {
    case 1: print("A")
    case 2, 3:
        print("B")
        //———!!!
        //the same case here!!!
    case 1: print("C")
    default: print("???")
    }

    var str                        = "hahaha~~"
    switch str {
    case "it is a winter day": str
    default: str
    }

    switch i{
    case -1...3:
        print("case 1")
    case -1...0, 0...2:
        print("case 2")
    default: break
        //       println("wo bu zhi dao")
    }

    let point                      = (0,4,1)
    switch point{
    case (0,_,_):
    print("x                       = 0, in y-axis")
        fallthrough
    case (_,0,_):
    print("y                       = 0, in x-axis")
        //———!!!
        //pickup the x & y
    case let (x,y,0):
    print("z                       = 0, in x-y-area, x=\(x), y=\(y)")
        //fallthrough
    case let (x,y,_) where x != y:
        print("x>y case")
    default: print(point)
    }

    /*************************************/
    str=""
    Renew:    for i in 0...20{
    str                            += "\(i)"
        for _ in 0...5 {
            if i==15 {
                break Renew
            }
            if i>=10 {
                continue Renew
            }
    str                            += "+"
        }
    }
    str

    /************************************/
    if #available(iOS 9, OSX 10.10, *) {
    // 在 iOS 使用 iOS 9 APIs , 并且在 OS X 使用 OS X v10.10 APIs
    } else {
    // 回滚至早前 iOS and OS X 的API
    }

}


func calc(){
    var n                          = 0x5p4//=0x5*2^4=5*1

    /*************************************/
    10 % 1.1    //Wrong!!!
    1 % 0.375   //OK
    10 % 1      //OK
    1.0 % 0.1   //Wrong!!!

    0x100>>2
    0x100<<2

    /*************************************/
    n++
    n
    ++n
    n                              = n>10 ? 0 : 1

    /*************************************/
    var a:Int?
    print("before: a=\(a), (a ?? 10)=\(a ?? 10)")
    a                              = 3
    print("after: a=\(a), (a ?? 10)=\(a ?? 10)")

    /*************************************/
    let yes                        = true
    let no                         = !yes
    no && yes   // AND
    no || yes   //OR

}



//base()
//flow()
//calc()
