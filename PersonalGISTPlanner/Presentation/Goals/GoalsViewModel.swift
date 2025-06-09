//
//  GoalsViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 01/06/25.
//

import Combine
import Foundation
import RealmSwift

class GoalsViewModel {
    @Published private(set) var activeGoals: Results<Plan>?
    @Published private(set) var completedGoals: Results<Plan>?

    private let localDataSource: PlanLocalDataSourceProtocol

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    func fetchGoals() {
        guard let allPlans = localDataSource.getAllPlans() else {
            print("No plans found")
            activeGoals = nil
            completedGoals = nil
            return
        }

        let goals = allPlans.filter("category == %@", PlanCategory.goal.rawValue)
        activeGoals = goals.filter("isCompleted == %@", false)
        completedGoals = goals.filter("isCompleted == %@", true)
    }

    func fetchRelatedTask(_ goalId: UUID) -> Results<Plan>? {
        guard let allPlans = localDataSource.getAllPlans() else {
            return nil
        }

        let tasks = allPlans.filter("category == %@", PlanCategory.task.rawValue)
        let relatedTasks = tasks.filter("goalId == %@", goalId)
        return relatedTasks
    }

    func countCompleteTask(for goalId: UUID) -> Int {
        guard let relatedTasks = fetchRelatedTask(goalId) else {
            return 0
        }
        return relatedTasks.filter("isCompleted == %@", true).count
    }

    func fetchRelatedItems(_ goalId: UUID) -> Results<Plan>? {
        guard let allPlans = localDataSource.getAllPlans() else {
            return nil
        }

        let relatedItems = allPlans.filter("goalId == %@", goalId)
        return relatedItems
    }

    func deleteGoal(plan: Plan) {
        let planID = plan.id

        localDataSource.deletePlan(plan: plan)

        let relatedItems = fetchRelatedItems(planID)!
        for item in relatedItems {
            localDataSource.deletePlan(plan: item)
        }

        fetchGoals()
    }

//    func isComplete(for id: UUID, plan: Plan) -> Bool {
//        guard let allPlans = localDataSource.getAllPlans() else {
//            return false
//        }
//
//        let relatedTasksCount = fetchRelatedTask(id)?.count
//        let completeTask = countCompleteTask(for: id)
//
//        if relatedTasksCount == 0 || completeTask == 0 {
//            return false
//        }
//
//        if relatedTasksCount == completeTask {
//            localDataSource.updatePlan(plan) { plan in
//                plan.isCompleted.toggle()
//            }
//        }
//
//        return relatedTasksCount == completeTask
//    }
}
