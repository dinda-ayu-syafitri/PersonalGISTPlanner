//
//  ItemSelectionViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 29/05/25.
//

import Foundation
import RealmSwift

class ItemSelectionViewModel {
    private let localDataSource: PlanLocalDataSourceProtocol
    private(set) var plans: Results<Plan>?

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    func fetchPlans(_ category: PlanCategory) -> Results<Plan>? {
        guard let allPlans = localDataSource.getAllPlans() else {
            print("No plans found in local data source")
            return nil
        }
        let filtered = allPlans.filter("category == %@", category.rawValue)
        plans = filtered
        return filtered
    }

    func fetchGoal() -> Results<Plan>? {
        return fetchPlans(.goal)
    }

    func fetchIdeas(_ goalId: UUID) -> Results<Plan>? {
        guard let allIdeas = fetchPlans(.idea) else { return nil }
        return allIdeas.filter("goalId == %@", goalId)
    }

    func fetchSteps(_ ideaId: UUID) -> Results<Plan>? {
        guard let allSteps = fetchPlans(.step) else { return nil }
        return allSteps.filter("ideaId == %@", ideaId)
    }
}
