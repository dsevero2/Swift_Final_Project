//
//  RoundDetails.swift
//  ScoreZ
//
//  Created by Dominic Severo on 4/30/22.
//

import Foundation

class Round: Codable{
    
    var course: String
    var date: Date
    var tees: String
    var yardage: Int
    var frontNine: Int
    var backNine: Int
    var total: Int
    var result: String
    
    internal init(course: String, date: Date, tees: String, yardage: Int, frontNine: Int, backNine: Int, total: Int, result: String) {
        self.course = course
        self.date = date
        self.tees = tees
        self.yardage = yardage
        self.frontNine = frontNine
        self.backNine = backNine
        self.total = total
        self.result = result
    }
    
    convenience init() {
        self.init(course: "", date: Date(), tees: "", yardage: 0, frontNine: 0, backNine: 0, total: 0, result: "")
    }
}
