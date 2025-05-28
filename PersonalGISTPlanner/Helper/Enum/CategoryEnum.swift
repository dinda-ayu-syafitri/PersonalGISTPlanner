//
//  CategoryEnum.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//
import RealmSwift

enum PlanCategory: String, PersistableEnum {
    case goal = "Goal"
    case idea = "Idea"
    case step = "Step"
    case task = "Task"
    case none = "Uncategorized"
}
