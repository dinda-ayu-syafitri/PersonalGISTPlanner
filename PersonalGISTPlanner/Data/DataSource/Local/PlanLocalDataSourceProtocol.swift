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
    func updatePlan(_ plan: Plan)
    func deletePlan(id: Int)
}
