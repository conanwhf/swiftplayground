//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
func typedefine(){
    /*************************************/
    struct Human {
        var height:Double
        let male:Bool
        let name:String
        func show() {
            let st = male ? "man":"woman"
            print("\(name), \(height)m, a \(st).")
        }
    }
    let conan:Human = Human( height:1.60, male:false, name:"Conan")
    conan.show()
    
    /*************************************/
    enum Famliy {
        case wangwang
        case miaomiao
        case little_miao, little_wang
    }
    let me:Famliy = .miaomiao
    print(me)
}


class MyClass : Comparable {
    var key : Int = 0
}

func < (left: MyClass, right: MyClass) -> Bool {
    return left.key < right.key
}

func == (left: MyClass, right: MyClass) -> Bool{
    return left.key == right.key
}


