//
//  Utility.swift
//  ASBInterviewExercise
//
//  Created by DonorRaja on 3/06/22.
//


import Foundation

class Utility: NSObject {
    
    //MARK: convertDateFormater
    class func convertDateFormater(_ inputDate: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let convertDate = dateFormatter.date(from: inputDate)
            //dateFormatter.dateFormat = "E d MMM yyyy"
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = "d MMM yyyy"
            return  convertDateFormatter.string(from: convertDate!)

        }

    //MARK: calculateGST
    class func calculateGST(excludeGST: Double,percentage: Double) -> Double {
        
        let gstAmount = (excludeGST*percentage)/100
        
        return gstAmount
    }
    
    //MARK: makeCurrencyFormatter
    class func makeCurrencyFormatter(currentAmount: Double) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        
        return currencyFormatter.string(from: NSNumber(value: currentAmount))!
    }
    
}

