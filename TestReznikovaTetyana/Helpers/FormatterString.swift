//
//  FormatterString.swift
//  TestReznikovaTetyana
//
//  Created by mac on 17.08.2024.
//

import Foundation

class FormatterString {
    
    
    static let shared = FormatterString()
   
    private init() {}
    
    func formatterStringToDate(string: String) -> Date{
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        if let textDate = formatterDate.date(from: string) {
            return textDate
        }
        return Date.now
    }
    
    func formatterDateToFetchString(date: Date) -> String {
        let formatterString = DateFormatter()
        formatterString.dateFormat = "yyyy-MM-dd"
        let dateString = formatterString.string(from: date)
        return dateString
    }
    
    func formatterDateToTitleString(date: Date) -> String {
        let formatterString = DateFormatter()
        formatterString.dateFormat = "MMMM d, yyyy"
        let dateString = formatterString.string(from: date)
        return dateString
        
    }
    
    func formatterString(string: String) -> String {
        let date = formatterStringToDate(string: string)
        let str = formatterDateToTitleString(date: date)
        return str
        
    }
    
}
