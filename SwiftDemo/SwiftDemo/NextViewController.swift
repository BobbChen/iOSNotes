//
//  NextViewController.swift
//  SwiftDemo
//
//  Created by 侨品汇 on 2017/11/27.
//  Copyright © 2017年 陈博. All rights reserved.
//

import UIKit


class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        let skipButton = UIButton.init(type: .custom)
        skipButton.frame = CGRect(x: 0, y: 0, width: 200, height: 30);
        skipButton.setTitle("自动引用计数", for:.normal);
        skipButton.backgroundColor = UIColor.white;
        skipButton.setTitleColor(UIColor.black, for: .normal);
        skipButton.center = view.center
        view.addSubview(skipButton);
        skipButton.addTarget(self, action: #selector(self.skipButtonEvent) , for: .touchUpInside);
        
        //MARK: 11.方法
        let count = Counter()
        count.increment()
        count.increment(by: 5)
        count.reset()
        
        var movePoint = Point(x: 2.0, y: 3.0)
        movePoint.moveByX(deltaX: 3.0, y: 4.0)
        
        someClass.someTypeMethod()
        let animalType = Animal(species: "")
        print("animalType = \(String(describing: animalType))")
    }
    
    @objc func skipButtonEvent() {
        let arcVc = ArcViewController()
        self.navigationController?.pushViewController(arcVc, animated: true)
    }
    
}
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count  = 0
    }
}

struct Point {
    //MARK: self属性
    var x = 0.0, y = 0.0
    
    func rightOfx(x: Double) -> Bool {
        // 参数名称和属性名称相同的时候，显式调用self以作区分
        return self.x > x
    }
    
    //MARK: 在实例方法中修改值类型
    // 枚举和结构体是值类型，默认情况下值类型的属性不能在它的实例方法中被修改，要使用可变方法mutating
    mutating func moveByX(deltaX: Double, y deltaY: Double){
        x += deltaX
        y += deltaY
    }
}
//MARK: 类型方法
class someClass {
    // 实例方法是被某个类型的实例所调用，类型方法是指被类型背身所调用的方法
    class func someTypeMethod() {
    }
}
struct LevelTracker {
    static var hightestUnlockLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int)  {
        if level > hightestUnlockLevel {
            hightestUnlockLevel = level
        }
        
    }
    
    static func isUnlocked(_ level: Int) -> Bool{
        return level <= hightestUnlockLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool{
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else{
            return false
        }
    }
}

//MARK: 12.继承
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
        
    }
    func makeNoise() {
        
    }
}
// 在class关键字之前加上final，表示该类不可以被继承
final class Bicycle: Vehicle {
    var hasBasket = false
    
    override init() {
        //调用super.init()之后currentSpeed才能被初始化
        super.init()
        currentSpeed = 2.0
    }
    
    // 重写方法
    override func makeNoise() {
        print("makeNoise")
    }
    // 重写属性
    override var description: String {
        return super.description + "override"
    }
    
}

//MARK: 13.构造过程
struct Fahrenheit {
    var temperature: Double
    init() {
        // 类和结构体中的属性初始化的时候需要有默认值
        temperature = 30
    
    }
}

// 自定义构造过程
struct Celius {
    var temperatureInCelsius:Double
    
    // 可选属性会在初始化的时候被设置为nil
    var response: String?
    
    // fromFahreheit: 外部参数 有自定义构造器的情况下无法访问默认构造器
    init(fromFahreheit fahreheit: Double) {
        temperatureInCelsius = (fahreheit - 32.0) / 18
    }
    
    // 省略构造方法的外部参数
    init(_ fahreheit: Double) {
        temperatureInCelsius = (fahreheit - 32.0) / 18
    }
}

// 如果类或结构体的属性已经有默认值并且没有自定义构造器，那么它会获得一个逐一构造器和一个默认构造器
class ShoppingListItem {
    var name: String?
    var boolValue = false
}

// 可是失败构造器
struct Animal {
    let species: String
    // 构造器不支持返回值，return nil 表示构造失败即可
    init!(species: String) {
        if species.isEmpty { return nil}
        self.species = species
    }
}















