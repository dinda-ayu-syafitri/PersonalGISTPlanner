//
//  CategoryEnum.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//
import RealmSwift

enum PlanCategory: String, PersistableEnum {
    case goal
    case idea
    case step
    case task
    case none
}
