//
//  PlanLocalDataSourceProtocol.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//
import RealmSwift

protocol PlanLocalDataSourceProtocol {
    func getAllPlans() -> Results<Plan>?
    func insertPlan(_ plan: Plan)
    func updatePlan(_ plan: Plan, updateBlock: (Plan) -> Void)
    func deletePlan(id: Int)
    func clearAllPlans()
}
