//
//  main.swift
//  L4_Chumachenko
//
//  Created by Александр Чумаченко on 15.03.2021.
//

import Foundation

typealias km = Double

/// Основной родительский класс Car/ Прородитель всего =)
class Car {
    ///Марка авто
    let make: String
    ///Модель авто
    let model: String
    ///Пробег
    var odometer: km
    ///Статус окон открыты/закрыты
    var windowStatus: Window
    ///Статус двигателя запущен/заглушен
    var engineStatus: EngineOnOff
    
    init(make: String, model: String, odometer: km) {
        self.make = make
        self.model = model
        self.odometer = odometer
        self.windowStatus = .close
        engineStatus = .off
    }
    
    enum EngineOnOff {
        case on, off
    }
    
    enum Window {
        case open, close
    }
    
    enum CarAction {
        case openWindows
        case closeWindows
        case engineOn
        case engineOff
        case printCarInfo
    }
    
    func odometerNewValue(km: Double) {
        if km > odometer {
            odometer = km
            print("Зафиксирован новый пробег на одометре - \(km) км")
        } else {
            print("Ты правда пытаешься скрутить пробег?")
            sleep(2)
            print("Увы, но мы против скручивания пробегов =(")
        }
    }
    
    func action (mode: CarAction) {
    }
}

///Спорткар наследник класса Car
class SportCar: Car {
    var transmission: Transmission
    var turbocharger: Bool
    var power: UInt
    var stockPower: UInt
    
    init(make: String, model: String, odometer: km, transmission: Transmission, horsePower: UInt, turbocharger: Bool) {
        self.transmission = transmission
        self.power = horsePower
        self.turbocharger = turbocharger
        stockPower = horsePower
        
        super.init(make: make, model: model, odometer: odometer)
    }
    
    enum Transmission: String {
        case manual = "Механика"
        case automatic = "Автомат"
        case robot = "Роботизированная"
        case variator = "Вариатор"
    }
    
    enum TuningStage {
        case stage1, stage2, stage3, stock
    }
    
    func tuning(stage: TuningStage) {
        switch stage {
        case .stage1:
            switch turbocharger {
            case false:
                turbocharger = true
                print("Установка турбо комплекта")
            case true:
                print("Замена турбины на более производительную")
            }
            power = UInt(Double(stockPower)*1.3)
        case .stage2:
            power = UInt(Double(stockPower)*1.5)
        case .stage3:
            power = UInt(Double(stockPower)*2.5)
        case .stock:
            power = stockPower
        }
    }
    
    override func action(mode: CarAction) {
        switch mode {
        case .closeWindows:
            windowStatus = .close
            print("Окна закрыты")
        case .openWindows:
            windowStatus = .open
            print("Окна открыты")
        case .engineOn:
            engineStatus = .on
            print("Двигатель запущен")
        case .engineOff:
            engineStatus = .off
            print("Двигатель заглушен")
        case .printCarInfo:
            print("-------------------------")
            print("Марка и модель автомобиля - \(make) \(model)")
            print("Пробег - \(odometer) км")
            print("Тип трансмиссии - \(transmission)")
            print("Мощность - \(power) л.с.")
            print("-------------------------")
        }
    }
}

class TrunkCar: Car {
    let trunkOverVolume: Double
    var trunkVolume: Double
    
    init(make: String, model: String, odometer: km, trunkOverVolume: Double) {
        self.trunkOverVolume = trunkOverVolume
        trunkVolume = 0
        
        super.init(make: make, model: model, odometer: odometer)
    }
    
    /**
     Положить в багажник n - килограмм
     ~~~
     Функция позволяет добавить в багажник нужное кол-во кг.
     ~~~
     - Parameter kg: Укажи вес в килограммах
     */
    func putInTruck (kg: Double) {
        if self.trunkVolume + kg <= self.trunkOverVolume {
            self.trunkVolume += kg
        } else {
            print("В багажнике твоего \(make) \(model) не может быть больше \(trunkOverVolume) кг.,\nУпакуем только то, что влезет.")
            trunkVolume = trunkOverVolume
        }
    }
    
    /**
     Изъять из багажника n - килограмм
     ~~~
     Функция позволяет  изъять из багажника нужное кол-во кг.
     ~~~
     - Parameter kg: Укажи вес в килограммах
     */
    func removeFromTruck (kg: Double) {
        if self.trunkVolume + kg >= 0 {
            self.trunkVolume -= kg
        } else {
            print("Ты не можешь вытащить из багажника больше, чем там сейчас есть.\nТак что я вытащил всё что было.")
            trunkVolume = 0.0
        }
    }
    
    override func action(mode: CarAction) {
        switch mode {
        case .closeWindows:
            windowStatus = .close
            print("Окна закрыты")
        case .openWindows:
            windowStatus = .open
            print("Окна открыты")
        case .engineOn:
            engineStatus = .on
            print("Двигатель запущен")
        case .engineOff:
            engineStatus = .off
            print("Двигатель заглушен")
        case .printCarInfo:
            print("-------------------------")
            print("Марка и модель автомобиля - \(make) \(model)")
            print("Пробег - \(odometer) км")
            print("Багажник загружен на \(trunkVolume)/\(trunkOverVolume)")
            print("-------------------------")
        }
    }
}

var myCar1 = SportCar(make: "BMW", model: "5-Series", odometer: 1856, transmission: .automatic, horsePower: 181, turbocharger: true)
var myCar2 = TrunkCar(make: "Dodge", model: "RAM", odometer: 465000, trunkOverVolume: 1000)

myCar1.action(mode: .engineOn)
myCar1.tuning(stage: .stage1)
myCar1.action(mode: .openWindows)
myCar1.action(mode: .printCarInfo)

myCar2.putInTruck(kg: 951)
myCar2.action(mode: .printCarInfo)
myCar2.removeFromTruck(kg: 50)
myCar2.action(mode: .engineOn)
myCar2.action(mode: .printCarInfo)
