//
//  Date.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation

extension Date{
    func GetCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
