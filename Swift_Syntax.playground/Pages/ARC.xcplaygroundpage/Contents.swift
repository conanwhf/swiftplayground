//: [Previous](@previous)

import Foundation

class Man{
    let name:String
    var gf:Woman?=nil
    weak var weak_gf:Woman?=nil
    
    init(name:String){ self.name = name }
    deinit{ print("release Man \(name), his girlfriend is \(gf?.name)") }
}

class Woman{
    let name:String
    var bf:Man?=nil
    weak var weak_bf:Man?=nil
    
    init(name:String){ self.name = name }
    deinit{print("release Woman \(name), her boyfriend is \(bf?.name)")}
}

//正常情况，释放内存
var boy1:Man?=Man(name: "ming-1")
var girl1:Woman?=Woman(name: "mei-1")
boy1!.gf=girl1
boy1=nil
girl1=nil

//循环引用，内存泄漏
var boy2:Man?=Man(name: "ming-2")
var girl2:Woman?=Woman(name: "mei-2")
boy2!.gf=girl2
girl2!.bf=boy2
boy2=nil
girl2=nil

//弱引用，循环，内存释放
var boy3:Man?=Man(name: "ming-3")
var girl3:Woman?=Woman(name: "mei-3")
boy3!.weak_gf=girl3
girl3!.weak_bf=boy3
boy3=nil
girl3=nil


//=======================================
class Mom{
    let name:String
    var son:Son?=nil
   
    init(name:String){ self.name = name }
    deinit{ print("release Mom \(name), her son is \(son?.name)") }
}
class Son{
    let name:String
    unowned var mom:Mom

    init(name:String,mother:Mom){
        self.name = name
        self.mom=mother
    }
    deinit{print("release Son \(name)")}
}
//无主引用
var a:Mom?=Mom(name: "Merry")
a!.son=Son(name: "J",mother: a!)
a=nil



//======================================
class ShowMe{
    let name="Test"
    var burn = 1984
    lazy var more:Int->Int = {
        year in
        print("My name is \(self.name), burned at \(self.burn). Any more? Nothing!")
        return year-self.burn
    }
    
    lazy var moreSave:Int->Int = {
        [unowned self] year in
        print("My name is \(self.name), burned at \(self.burn). Any more? Nothing!")
        return year-self.burn
    }
    
    deinit{print("release me: \(name)")}
}
//闭包强引用，内存泄漏
var c:ShowMe?=ShowMe()
c?.more
c=nil
//定义捕获列表，内存释放
var d:ShowMe?=ShowMe()
d?.moreSave
d=nil
