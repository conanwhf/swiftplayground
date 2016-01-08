//: [Previous](@previous)

import Foundation

func base(){
    let arr : Array<Int> = [1, 3, -4, 0, -9, 28]
    var res: Array<Int>

    func mysort(a: Int, b: Int) -> Bool{
        return abs(a) > abs(b)
    }
    arr.sort(mysort)

    res = arr.sort({
        (a: Int, b:Int)->Bool in
        return a>b
    })
    res = arr.sort(){ a, b in return a>b }
    res = arr.sort{ a, b in return a>b }
    res = arr.sort{ a, b in a>b }
    res = arr.sort{  $0>$1 }
    res = arr.sort( > )

    // Same thing
    arr.map({ (a:Int)->Int in
        return a+1
    })
    arr.map{a in return a+1}
    arr.map{a in a+1}
    arr.map{$0+1}
}


func catch_test(){
    func test1(a:Int...) -> ()->Int {
        func myfunc()->Int {
            var total = 0
            print("test1-myfunc, total=\(total)")
            a.forEach{ total = total+$0 }
            return total
        }
        return myfunc
    }
    
    func test2(a:Int...) -> ()->Int {
        var total = 0
        a.forEach{ total = total+$0 }
        print("test2, total=\(total)")
        func myfunc()->Int {
            print("test2-myfunc, total=\(total)")
            return total
        }
        return myfunc
    }
    
    func test3(a:Int...) -> ()->Int {
        var total = 0
        print("test3, total=\(total)")
        func myfunc()->Int {
            print("test3-myfunc, total=\(total)")
            a.forEach{ total = total+$0 }
            return total
        }
        return myfunc
    }

    var myTest = test1(1,2,3,4,5)
    myTest()
    myTest()

    myTest = test2(1,2,3,4,5)
    myTest()
    myTest()
    //捕获total，且可以修改total
    myTest = test3(1,2,3,4,5)
    myTest()
    myTest()
    //独立保存另一份total值
    var myTestAgain = test2(1,2,3,4)
    myTestAgain()
    myTestAgain()
    myTestAgain = myTest
    myTestAgain()
}


func escape(){
    typealias OPTYPE = ()->Void
    var opt:OPTYPE = {}
    
    func setOp( @noescape a: OPTYPE ){
        a()
        //opt = a     //WRONG!!!
    }
    
    func op_print(){
        print(__FUNCTION__)
    }
    
    func setOp2( a: OPTYPE ){
        a()
        opt = a
    }

    setOp{print("TEST NOESCAPE") }
    setOp(op_print)

    setOp2{print("TEST ESCAPE") }
    opt()
    setOp2(op_print)
    opt()
}


//base()  //闭包的定义和简化写法
//catch_test()    //闭包中的捕获值
//escape()

