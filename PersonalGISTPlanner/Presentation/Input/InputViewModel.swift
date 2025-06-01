//
//  InputViewModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 27/05/25.
//

import Combine
import Foundation

class InputViewModel: ObservableObject {
    private let localDataSource: PlanLocalDataSourceProtocol

    init(localDataSource: PlanLocalDataSourceProtocol = PlanLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var selectedGoal: Plan?
    @Published var selectedIdea: Plan?
    @Published var selectedStep: Plan?
    @Published var selectedCategory: PlanCategory = .goal
    @Published var selectedDueDate: Date = .init()

    var cancellables = Set<AnyCancellable>()

    func savePlan() {
        let plan = Plan()
        plan.title = title
        plan.desc = desc
        plan.category = selectedCategory
        plan.dueDate = selectedDueDate
        plan.goalId = selectedGoal?.id
        plan.ideaId = selectedIdea?.id
        plan.stepId = selectedStep?.id

        print("title: \(plan.title)")
        print("desc: \(plan.desc)")
        print("category: \(plan.category)")
        print("Due Date: \(plan.dueDate)")
        print("Goal ID: \(plan.goalId?.uuidString ?? "none")")
        print("Idea ID: \(plan.ideaId?.uuidString ?? "none")")
        print("Step ID: \(plan.stepId?.uuidString ?? "none")")

        localDataSource.insertPlan(plan)
    }
}
