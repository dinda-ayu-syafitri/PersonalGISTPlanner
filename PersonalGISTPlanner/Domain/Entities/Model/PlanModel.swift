//
//  PlanModel.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//

import Foundation
import RealmSwift

class Plan: Object {
    @Persisted var id = UUID()
    @Persisted var title: String
    @Persisted var desc: String
    @Persisted var dueDate: Date
    @Persisted var category: PlanCategory
    @Persisted var isCompleted: Bool = false
    @Persisted var createdAt: Date = .init()
    @Persisted var goalId: UUID?
    @Persisted var ideaId: UUID?
    @Persisted var stepId: UUID?
}
