//
//  GoalsViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 01/06/25.
//

import Combine
import Foundation
import RealmSwift

class GoalsViewModel {
    @Published private(set) var activeGoals: Results<Plan>?
    @Published private(set) var completedGoals: Results<Plan>?

    private let localDataSource: PlanLocalDataSourceProtocol

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    func fetchGoals() {
        guard let allPlans = localDataSource.getAllPlans() else {
            print("No plans found")
            activeGoals = nil
            completedGoals = nil
            return
        }

        let goals = allPlans.filter("category == %@", PlanCategory.goal.rawValue)
        activeGoals = goals.filter("isCompleted == %@", false)
        completedGoals = goals.filter("isCompleted == %@", true)
    }
}
