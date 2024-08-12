//
//  UIColor + Extensions.swift
//  RickAndMorty
//
//  Created by KOДИ on 10.08.2024.
//

import UIKit

extension UIColor {
    
    //StatusView
    static let aliveColor = UIColor(hex: "#198737")
    static let deadColor = UIColor(hex: "#D62300")
    static let unknowColor = UIColor(hex: "#686874")
    
    //TextsColor
    static let whiteTextColor = UIColor(hex: "#FFFFFF")
    
    //Button
    static let defaultButtonColor = UIColor(hex: "#42B4CA")
    
    //ContainerView
    static let containerViewColor = UIColor(hex: "#151517")
}

extension UIColor {
    // Инициализация UIColor из строки HEX
    convenience init(hex: String, defaultColor: UIColor = .systemPink) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Удаляем символ # если он есть
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        // Проверяем, содержит ли строка 6 или 8 символов
        guard hexFormatted.count == 6 || hexFormatted.count == 8 else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        
        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: hexFormatted)
        guard scanner.scanHexInt64(&rgbValue) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        
        let alpha: CGFloat
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        
        if hexFormatted.count == 8 {
            // Если строка содержит 8 символов, читаем значение альфа-канала
            alpha = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            red = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            green = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            blue = CGFloat(rgbValue & 0x000000FF) / 255.0
        } else {
            // Если строка содержит 6 символов, задаём альфа-канал как 1.0 (полностью непрозрачный)
            alpha = 1.0
            red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

