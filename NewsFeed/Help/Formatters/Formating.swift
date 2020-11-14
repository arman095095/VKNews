//
//  Formating.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 13.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation


class Formating {
    //Форматируем вывод количества лайков и тд
    func setupCountableItemPresentation(countOf:Int?) -> String {
        guard let count = countOf else { return "" }
        if count == 0 { return "" }
        
        let countDouble = Double(count)
        if count > 999 && count < 1000000 {
            let str = String(format: "%.1f", countDouble/1000)
            if str.last != "0" {
                return String(format: "%.1f", countDouble/1000) + "K" }
            else {
                return "\(Int(countDouble/1000))" + "K"
            }
        }
        else if count >= 1000000 {
            let str = String(format: "%.1f", countDouble/1000000)
            if str.last != "0" {
                return String(format: "%.1f", countDouble/1000000) + "M" }
            else {
                return "\(Int(countDouble/1000000))" + "M"
            }
        } else {
            return "\(count)"
        }
    }
    func setupCountableItemPresentationForViews(countOf:Int?) -> String {
        guard let count = countOf else { return "" }
        if count == 0 { return "" }
        if count > 999 && count < 1000000 { return "\(Int(count/1000))" + "K" }
        if count >= 1000000 { return "\(Int(count/1000000))" + "M" }
        return "\(count)"
    }
    func dateFormate(date:Double) -> String {
        let newDate = Date(timeIntervalSince1970: date)
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_Ru")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt.string(from: newDate)
    }
}
