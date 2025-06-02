//
//  CategorizedListViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 02/06/25.
//

import Combine
import Foundation
import RealmSwift

class CategorizedListViewModel {
    private let localDataSource: PlanLocalDataSourceProtocol
    private(set) var plans: Results<Plan>?

    @Published var items: Results<Plan>?
    @Published var selectedItem: Plan?

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

    func fetchIdeas() {
        let allIdeas = fetchPlans(.idea)
        guard let itemId = selectedItem?.id else { return }
        items = allIdeas?.filter("goalId == %@", itemId)
    }

    func fetchSteps() {
        let allSteps = fetchPlans(.step)
        guard let itemId = selectedItem?.id else { return }
        items = allSteps?.filter("ideaId == %@", itemId)
    }

    func fetchTasks() {
        let allSteps = fetchPlans(.task)
        guard let itemId = selectedItem?.id else { return }
        items = allSteps?.filter("stepId == %@", itemId)
    }
}
