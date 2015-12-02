//: [Previous](@previous)

import Foundation

/**
 ASCII value to char
 */
func ASCII ( n : Int) -> String? {
    guard (n >= 0 && n < 255 ) else {
        return nil
    }
    return String(format:"%c", n)
}

/**
 ASCII char to int value
*/
func ASCII (c : String) -> Int8?{
    let str:NSString = c
    let n = str.UTF8String[0]
    guard n>=0 else {
        return nil
    }
    return n
}


ASCII(70)
ASCII("B")
