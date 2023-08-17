//
//  Date.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation

extension Date{
    func GetCurrentTime(format : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}
