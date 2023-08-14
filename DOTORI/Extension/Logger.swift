//
//  Logger.swift
//  DOTORI
//
//  Created by 박유경 on 2023/08/14.
//

import Foundation
//사용법 : print(Logger.Write(LogLevel.Info)("HomeViewController")(83)("더미 데이터를 API데이터 변환 필요"))           이런식으로 사용
#if DEBUG
class Logger{
    static func Write(_ logLevel : LogLevel) -> (String) -> (Int) -> (String) -> String {
        var totalLog = "";
        var preFixEmoji = ""
        switch logLevel{
        case .Debug:
            preFixEmoji = "\u{1F7E2}" //녹색
            totalLog = "[\(preFixEmoji) Debug] : "
            
        case .Info:
            preFixEmoji = "\u{1F535}" //파란색
            totalLog =  "[\(preFixEmoji) Info] : "
            
        case .Error:
            preFixEmoji = "\u{1F534}" //빨간색
            totalLog =  "[\(preFixEmoji) Error] : "
        case .Warning:
            preFixEmoji = "\u{1F7E1}" //노란색
            totalLog =  "[\(preFixEmoji) Warning] : "
            
        case .Unknown:
            preFixEmoji = "\u{26AB}" //검은색
            totalLog =  "[\(preFixEmoji) Unknown] : "
        }
        
        return { typeOfClass in
            return {writeLine in
                return {LogMessage in
                    totalLog = totalLog + "\(typeOfClass)[\(String(writeLine))]" +  " ->  \(LogMessage)"
                    return totalLog
                }
            }
            
        }
    }
    
}
enum LogLevel: String {
    case Debug
    case Info
    case Error
    case Warning
    case Unknown
}
#endif
