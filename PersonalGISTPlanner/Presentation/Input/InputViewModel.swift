//
//  InputViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 27/05/25.
//

class InputViewModel {
    private let localDataSource: PlanLocalDataSourceProtocol

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    func savePlan(_ plan: Plan) {
        localDataSource.insertPlan(plan)
    }
}
