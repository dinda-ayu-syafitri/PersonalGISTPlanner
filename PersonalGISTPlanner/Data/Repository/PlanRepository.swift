//
//  PlanRepository.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 27/05/25.
//
import Foundation
import RealmSwift

protocol PlanRepositoryProtocol {
    func fetchPlans() -> Results<Plan>?
    func addPlan(_ plan: Plan)
}

class PlanRepository: PlanRepositoryProtocol {
    private let planLocalData: PlanLocalDataSource

    init(planLocalData: PlanLocalDataSource) {
        self.planLocalData = planLocalData
    }

    func fetchPlans() -> Results<Plan>? {
        let localData = planLocalData.getAllPlans()
        return localData
    }

    func addPlan(_ plan: Plan) {
        let localData = planLocalData.insertPlan(plan)
    }
}
