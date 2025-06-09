//
//  CategorizedListViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 02/06/25.
//

import Combine
import Foundation
import RealmSwift

class CategorizedListViewModel: ObservableObject {
    private let localDataSource: PlanLocalDataSourceProtocol
    private(set) var plans: Results<Plan>?
    private var taskNotificationToken: NotificationToken?

    @Published var items: Results<Plan>?
    @Published var selectedItem: Plan?

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
        observeTaskChanges()
    }

    deinit {
        taskNotificationToken?.invalidate()
    }

    private func observeTaskChanges() {
        guard let tasks = fetchAllTask() else { return }

        taskNotificationToken = tasks.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                DispatchQueue.main.async {
                    self?.objectWillChange.send()
                }
            case .error(let error):
                print("Task observation error: \(error)")
            }
        }
    }

    func fetchPlans(_ category: PlanCategory) -> Results<Plan>? {
        guard let allPlans = localDataSource.getAllPlans() else {
            print("No plans found in local data source")
            return nil
        }
        let filtered = allPlans.filter("category == %@", category.rawValue)
        plans = filtered
        return filtered
    }

    func fetchIdeas() {
        let allIdeas = fetchPlans(.idea)
        guard let itemId = selectedItem?.id else { return }
        items = allIdeas?.filter("goalId == %@", itemId)
    }

    func fetchSteps() {
        let allSteps = fetchPlans(.step)
        guard let itemId = selectedItem?.id else { return }
        items = allSteps?.filter("ideaId == %@", itemId)
    }

    func fetchTasks() {
        let allSteps = fetchPlans(.task)
        guard let itemId = selectedItem?.id else { return }
        items = allSteps?.filter("stepId == %@", itemId)
    }

    func getGoalById(id: UUID) -> Plan? {
        let allGoals = fetchPlans(.goal)
        let goal = allGoals?.filter("id == %@", id)
        return goal?.first
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

    func isCompleteGoal(for id: UUID, plan: Plan) -> Bool {
        let relatedTasksCount = fetchRelatedTask(id)?.count
        let completeTask = countCompleteTask(for: id)

        if relatedTasksCount == 0 || completeTask == 0 {
            return false
        }

        if relatedTasksCount == completeTask {
            localDataSource.updatePlan(plan) { plan in
                plan.isCompleted.toggle()
            }
        }

        return relatedTasksCount == completeTask
    }

    func toggleTaskCompletion(_ task: Plan) {
        localDataSource.updatePlan(task) { plan in
            plan.isCompleted.toggle()
        }

        guard let taskGoalId = task.goalId else { return }
        guard let goal = getGoalById(id: taskGoalId) else { return }

        localDataSource.updatePlan(goal) { plan in
            plan.isCompleted.toggle()
        }
    }

    func fetchAllTask() -> Results<Plan>? {
        guard let allPlans = localDataSource.getAllPlans() else {
            return nil
        }

        let tasks = allPlans.filter("category == %@", PlanCategory.task.rawValue)
        return tasks
    }

    func isComplete(for id: UUID, category: PlanCategory, plan: Plan) -> Bool {
        guard let allPlans = localDataSource.getAllPlans() else {
            return false
        }

        let tasks = allPlans.filter("category == %@", PlanCategory.task.rawValue)
        var relatedTasksCount = 0
        var completeTask = 0

        if category == .idea {
            let relatedTasks = tasks.filter("ideaId == %@", id)
            relatedTasksCount = relatedTasks.count
            completeTask = relatedTasks.filter("isCompleted == %@", true).count
        } else if category == .step {
            let relatedTasks = tasks.filter("stepId == %@", id)
            relatedTasksCount = relatedTasks.count
            completeTask = relatedTasks.filter("isCompleted == %@", true).count

        } else {
            return true
        }

        if relatedTasksCount == 0 || completeTask == 0 {
            return false
        }

        if relatedTasksCount == completeTask {
            localDataSource.updatePlan(plan) { plan in
                plan.isCompleted.toggle()
            }
        }

        return relatedTasksCount == completeTask
    }
}
