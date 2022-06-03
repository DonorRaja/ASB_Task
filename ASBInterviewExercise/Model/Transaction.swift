//
//  Transaction.swift
//  ASBInterviewExercise
//
//  Created by DonorRaja on 3/06/22.
//

import Foundation


struct Transaction: Decodable {
    let id : Int
    var transactionDate: String
    let summary: String
    var debit : Double
    let credit: Double
    
}

