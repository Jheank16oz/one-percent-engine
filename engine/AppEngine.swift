//
//  AppEngine.swift
//  engine
//
//  Created by Jhean Carlos Pineros Diaz on 16/04/23.
//

import Foundation

protocol GoalsRepository {
    func create(goal: Goal)
    func listToday() async -> [Goal]
}

enum AppEngineError: Error {
    case EmptySubjectCreation
}

class AppEngine {
    private let repository:GoalsRepository
    func todayGoals() async -> [Goal] {
        await repository.listToday()
    }
    
    init(repository: GoalsRepository) {
        self.repository = repository
    }
    
    func addGoal(with goal: Goal) throws {
        if goal.subject.isEmpty {
            throw AppEngineError.EmptySubjectCreation
        }else {
            repository.create(goal: goal)
        }
    }
}
