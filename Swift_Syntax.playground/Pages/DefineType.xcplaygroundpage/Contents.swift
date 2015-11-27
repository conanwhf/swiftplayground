//: [Previous](@previous)

import Foundation


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
    debugPrint(me)
}