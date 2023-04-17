//
//  AppEngineTests.swift
//  engineTests
//
//  Created by Jhean Carlos Pineros Diaz on 16/04/23.
//

import Foundation
import XCTest
@testable import engine

class AppEnngineTests: XCTestCase {
    
    func test_should_init_with_empty_goals() {
        let localRepository = SpyRepository()
        let sut = AppEngine.init(repository: localRepository)
        let goals = sut.todayGoals
        
        XCTAssertTrue(goals.count == 0)
    }
    
    func test_shoud_invoke_goals_creation() throws {
        let localRepository = SpyRepository()
        let sut = AppEngine.init(repository: localRepository)
        
        // when
        let goal = Goal(subject:"Any Goal", type: .family)
        try sut.addGoal(with: goal)
        
        // then
        XCTAssertTrue(localRepository.createGoalInvokes == 1)
        XCTAssertEqual(localRepository.goals[0], goal)
    }
    
    func test_shoud_throws_and_does_not_invoke_goals_creation_with_empty_subject() throws {
        let localRepository = SpyRepository()
        let sut = AppEngine.init(repository: localRepository)
        
        XCTAssertThrowsError(try sut.addGoal(with: Goal(subject:"", type: .family))) { error in
            XCTAssertEqual(error as! AppEngineError, AppEngineError.EmptySubjectCreation)
        }
        XCTAssertTrue(localRepository.createGoalInvokes == 0)
    }
    
    func test_shoud_list_goals_if_these_are_configured() throws {
        let localRepository = SpyRepository()
        let sut = AppEngine.init(repository: localRepository)
        let goals = [
            Goal(subject: "Read", type: .educational),
            Goal(subject: "Excercise", type: .personal),
            Goal(subject: "Spend time with girlfriend", type: .family),
            Goal(subject: "Start course of TDD", type: .educational)]
        
        try goals.forEach { goal in
            try sut.addGoal(with: goal)
        }
    
        XCTAssertEqual(sut.todayGoals, goals)
        XCTAssertTrue(localRepository.listGoalInvokes == 1)
    }
    
    func test_shoud_wait_for_goals_if_these_are_configured() throws {
        let localRepository = SpyRepository()
        let sut = AppEngine.init(repository: localRepository)
        let goals = [
            Goal(subject: "Read", type: .educational),
            Goal(subject: "Excercise", type: .personal),
            Goal(subject: "Spend time with girlfriend", type: .family),
            Goal(subject: "Start course of TDD", type: .educational)]
        
        try goals.forEach { goal in
            try sut.addGoal(with: goal)
        }
    
        XCTAssertEqual(sut.todayGoals, goals)
        XCTAssertTrue(localRepository.listGoalInvokes == 1)
    }
    
    
    // MARK: Helpers
    class SpyRepository: GoalsRepository {
        var goals:[Goal] = []
        var createGoalInvokes = 0
        var listGoalInvokes = 0
        
        func create(goal: Goal) {
            goals.append(goal)
            createGoalInvokes += 1
        }
        
        func listToday() -> [engine.Goal] {
            listGoalInvokes += 1
            return goals
        }
    }
}
