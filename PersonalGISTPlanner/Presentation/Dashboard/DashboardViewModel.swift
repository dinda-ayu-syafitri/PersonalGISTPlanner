//
//  DashboardViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 27/05/25.
//
import Foundation
import RealmSwift

class DashboardViewModel {
    private let localDataSource: PlanLocalDataSourceProtocol
    private(set) var plans: Results<Plan>?

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
        fetchPlans()
    }

    func fetchPlans() {
        plans = localDataSource.getAllPlans()
    }
}
