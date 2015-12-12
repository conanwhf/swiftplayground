//: [Previous](@previous)

import Foundation


enum Area {
    case AMK
    case Bishan
    case Yishun
    case Orchard
}

enum Area2 {
    case AMK, Bishan, Yishun, Orchard
}

enum AreaNull {
    //Can be empty
}

enum AreaRawString : String {
    case AMK = "AMK"
    case Bishan = "Bishan"
    case Yishun = "Yishun"
    case Orchard = "Orchard"
    //case ABC = 3            // WRONG!!!
    //case AAA = "AMK"    // WRONG!!!
}

enum AreaRawInt : Int {
    case AMK = 4
    case Bishan     // Auto fill to 5
    case Yishun = 1
    case Orchard    // Auto fill to 2
}


var a : Area = .AMK
var a2 : Area2 = .AMK
var aNull : AreaNull
var aRawString : AreaRawString = .AMK
var aRawInt : AreaRawInt = .AMK



a.hashValue == 0        //Always be 0

AreaRawInt.Bishan.rawValue
AreaRawInt.Yishun.rawValue
AreaRawInt(rawValue: 0)
AreaRawInt(rawValue: 2)
