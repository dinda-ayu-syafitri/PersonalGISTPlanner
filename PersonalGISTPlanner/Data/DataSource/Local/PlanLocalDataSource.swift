//
//  PlanLocalDataSource.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//
import RealmSwift

class PlanLocalDataSource: PlanLocalDataSourceProtocol {
    let realm = try? Realm()

    func getAllPlans() -> Results<Plan>? {
        let plans = realm?.objects(Plan.self)
        return plans
    }

    func insertPlan(_ plan: Plan) {
        do {
            try realm?.write {
                realm?.add(plan)
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }

    func updatePlan(_ plan: Plan) {
        // TODO: Update Plan
    }

    func deletePlan(id: Int) {
        // TODO: Delete Plan
    }
}
