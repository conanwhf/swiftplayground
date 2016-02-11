//: [Previous](@previous)

import Foundation

protocol CutLast{
    typealias Type
    var count:Int{get}
    func cutLast()->Type
}

class TestClass : Comparable {
    var key : Int = 0
}


extension String: CutLast{
    var count:Int{
        get{
            return self.characters.count
        }
    }
    func cutLast()->String{
        return String(self.characters.dropLast())
    }
}


extension TestClass: CutLast{
    var count:Int{
        get{
            return key
        }
    }
    func cutLast()->TestClass{
        return self
    }
}

// 添加可比较支持

func < (left: TestClass, right: TestClass) -> Bool {
    return left.key < right.key
}

func == (left: TestClass, right: TestClass) -> Bool{
    return left.key == right.key
}


var st="test"
st.cutLast()