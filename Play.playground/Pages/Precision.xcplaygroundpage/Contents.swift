//: [Previous](@previous)

import UIKit

sizeof(Int)*8
sizeof(UInt)*8
sizeof(UInt16)*8
sizeof(UInt32)*8
sizeof(UInt64)*8
sizeof(Int64)*8

sizeof(Float)*8
sizeof(Double)*8
sizeof(CGFloat)*8
sizeof(CGFloat.NativeType.self)*8

//结构体大小，不是数据精度
sizeof(Character)*8
sizeof(String)*8
sizeof(CGRect)*8
sizeof(CGPoint)*8
sizeof(CGSize)*8
sizeof(UIColor)*8


func precisionTest (div: CGFloat) -> Int{
    var a : Int = 0
    var b : CGFloat
    var c : Int
    repeat {
        a = a + 1
        b = CGFloat(Float(a) / Float(div)) // for Float
        //b = CGFloat(a) / div    // for CGFloat
        c = Int(b * div)
    }while c == a
    print("div=\(div), a=\(a), b=\(b) @\(b*div), c=\(c) @ \(Double(c)/Double(div))")
    return a
}


//precisionTest(CGFloat(1 << 63))
//precisionTest(4321)

var res = Set<Int>()
for i in 3...10000 {
    if ![2,4,8,16,32,64,128,256,512,1024,2048,4096,8192].contains(i){
        res = res.union( [precisionTest(CGFloat(i))] )
    }
}
Array(res).sort()