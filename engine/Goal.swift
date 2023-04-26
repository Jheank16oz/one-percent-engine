//
//  Goal.swift
//  engine
//
//  Created by Jhean Carlos Pineros Diaz on 16/04/23.
//

import Foundation

struct Goal: Equatable {
    var subject:String
    var type:GoalType
    var status:GoalStatus = .toDo
}

enum GoalStatus {
    case toDo
    case done
}

enum GoalType {
    case family
    case work
    case educational
    case financial
    case personal
    case relationship
    case buiseness
    case health
    case spiritual
    case career
    case social
}
