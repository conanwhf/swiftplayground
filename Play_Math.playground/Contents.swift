//: Playground - noun: a place where people can play

import UIKit

//http://www.cocoachina.com/ios/20150727/12794.html

/*************************************/
//二分法查找平方根
func sqrt_bisection(x: Double) -> Double {
    //1
    var lower = 1.0
    //2
    var upper = x
    //3
    var m = (lower + upper) / 2
    var epsilon = 1e-10
    //4
    while (fabs(m * m - x) > epsilon) {
        //5
        m = (lower + upper) / 2
        if m * m > x {
            upper = m
        } else {
            lower = m
        }
    }
    
    return m
}


/************************************
平方根，希罗算法
https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method
*/
func sqrt_heron(x: Double) -> Double {
    //1
    var xOld = 0.0
    var xNew = (x + 1.0) / 2.0
    var epsilon = 1e-10
    
    //2
    while (fabs(xNew - xOld) > epsilon) {
        //3
        xOld = xNew
        xNew = (xOld + x / xOld) / 2
    }
    
    return xNew
}

/*************************************/
//模拟谐振子运动
typealias Solver = (Double, Double, Double, Double, Double) -> Void
struct HarmonicOscillator {
    var kSpring = 0.0
    var mass = 0.0
    var phase = 0.0
    var amplitude = 0.0
    var deltaT = 0.0
    init(kSpring: Double, mass: Double, phase: Double, amplitude: Double, deltaT: Double) {
        self.kSpring = kSpring
        self.mass = mass
        self.phase = phase
        self.amplitude = amplitude
        self.deltaT = deltaT
    }
    func solveUsingSolver(solver: Solver) {
        solver(kSpring, mass, phase, amplitude, deltaT)
    }
}
func solveExact(amplitude: Double, phase: Double, kSpring: Double, mass: Double, t: Double) {
    var x = 0.0
    //1
    let omega = sqrt(kSpring / mass)
    
    var i = 0.0
    
    while i < 100.0 {
        //2
        x =  amplitude * sin(omega * i + phase)
        i += t
    }
}


/************************************
欧拉方法
http://en.wikipedia.org/wiki/Euler_method
欧拉方法的核心思想是通过使用折线逼近曲线。具体方法是计算一个给定点的斜率，然后绘制一条同样斜率的折线。在这条折线的末尾，继续计算斜率，绘制另外一条线。该算法的精确度取决于折线的长度
*/
func solveEuler(amplitude: Double, phase: Double, kSpring: Double, mass: Double, t: Double) {
    //1
    var x = amplitude * sin(phase)
    let omega = sqrt(kSpring / mass)
    var i = 0.0
    //2
    var v = amplitude * omega * cos(phase);
    var vold = v
    var xoldEuler = x
    
    while i < 100 {
        //3
        v -= omega * omega  * x * t
        //4
        x += vold * t
        xoldEuler = x
        
        vold = v
        i+=t
    }
}


/******************************
速度Verlet算法(Velocity Verlet)
和欧拉方法的思路一样，但是计算新位置的方式有些许差异。欧拉在计算新位置时，忽略实际的加速度，而速度Verlet算法在计算时考虑到了加速度。这在步长相等的时候，结果更优。
*/
func solveVerlet(amplitude: Double, phase: Double, kSpring: Double, mass: Double, t: Double) {
    //1
    var x = amplitude * sin(phase)
    var xoldVerlet = x
    let omega = sqrt(kSpring / mass)
    
    var v = amplitude * omega * cos(phase)
    var vold = v
    var i = 0.0
    
    while i < 100 {
        //2
        x = xoldVerlet + v * t + 0.5 * omega * omega * t * t
        v -= omega * omega * x * t
        xoldVerlet = x
        i+=t
    }
}


//sqrt_bisection(50)
//sqrt_heron(50)

let osci = HarmonicOscillator(kSpring: 0.5, mass: 10, phase: 10, amplitude: 50, deltaT: 0.1)
osci.solveUsingSolver(solveExact)
osci.solveUsingSolver(solveEuler)
osci.solveUsingSolver(solveVerlet)