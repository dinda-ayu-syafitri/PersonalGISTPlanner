//
//  DashboardViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 27/05/25.
//
import Combine
import Foundation
import RealmSwift

import Combine
import Foundation
import RealmSwift

class DashboardViewModel: ObservableObject {
    private let localDataSource: PlanLocalDataSourceProtocol

    @Published var plans: Results<Plan>?
    @Published var completedTask: Int = 0
    @Published var totalTask: Int = 0

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    func fetchData() {
        guard let allPlans = localDataSource.getAllPlans() else {
            print("No plans found in local data source")
            return
        }

        let goalPlans = allPlans.filter("category == %@", PlanCategory.goal.rawValue)
        let taskPlans = allPlans.filter("category == %@", PlanCategory.task.rawValue)

        DispatchQueue.main.async {
            self.plans = goalPlans
            self.completedTask = taskPlans.filter("isCompleted == true").count
            self.totalTask = taskPlans.count
        }
    }

    func clear() {
        localDataSource.clearAllPlans()
    }
}
