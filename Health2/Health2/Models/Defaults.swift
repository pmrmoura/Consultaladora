//
//  Defaults.swift
//  Health2
//
//  Created by Pedro da Matta Ribeiro Moura on 10/03/20.
//  Copyright © 2020 Pedro da Matta Ribeiro Moura. All rights reserved.
//

import Foundation

class Defaults {
    var name: String
    var goal: Int
    var goalProgress: Int
    init(name:String, goal: Int, goalProgress:Int) {
       self.name = name
       self.goal = goal
       self.goalProgress = goalProgress
    }
}
