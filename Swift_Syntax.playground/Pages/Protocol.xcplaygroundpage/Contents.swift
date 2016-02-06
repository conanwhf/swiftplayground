//: [Previous](@previous)

import Foundation

// 添加可比较支持
class TestClass : Comparable {
    var key : Int = 0
}

func < (left: TestClass, right: TestClass) -> Bool {
    return left.key < right.key
}

func == (left: TestClass, right: TestClass) -> Bool{
    return left.key == right.key
}

