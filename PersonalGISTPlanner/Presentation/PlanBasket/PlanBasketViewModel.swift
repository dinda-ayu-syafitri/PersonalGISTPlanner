//
//  PlanBasketViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 02/06/25.
//

import Foundation
import RealmSwift

class PlanBasketViewModel: ObservableObject {
    private let localDataSource: PlanLocalDataSourceProtocol
    private(set) var plans: Results<Plan>?

    @Published var items: Results<Plan>?
    @Published var selectedItem: Plan?

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
        fetchUncategorizedPlans()
    }

    func fetchUncategorizedPlans() {
        guard let allPlans = localDataSource.getAllPlans() else {
            print("No plans found in local data source")
            return
        }
        let filtered = allPlans.filter("category == %@", PlanCategory.none.rawValue)
        items = filtered
    }

    func fetchPlansByKeyword(_ keyword: String) {
        fetchUncategorizedPlans()
        let filtered = items?.filter("title CONTAINS[cd] %@", keyword)
        items = filtered
    }
}
