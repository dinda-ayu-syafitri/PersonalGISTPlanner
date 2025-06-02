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

    func updatePlan(_ plan: Plan, updateBlock: (Plan) -> Void) {
        do {
            try realm?.write {
                updateBlock(plan)
            }
        } catch {
            print("Error updating plan: \(error)")
        }
    }

    func deletePlan(id: Int) {
        // TODO: Delete Plan
    }

    func clearAllPlans() {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.deleteAll()
        }

        print("Realm data cleared.")
    }
}
