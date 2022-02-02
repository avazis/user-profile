//
//  Helpers.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation


func df()->DateFormatter{
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-d"
    return formatter
}

func dateToString(date: Date) -> String{
    let formatter = df()
    return formatter.string(from: date)
}


func stringToDate(string: String) -> Date?{
    let formatter = df()
    return formatter.date(from: string)
}
