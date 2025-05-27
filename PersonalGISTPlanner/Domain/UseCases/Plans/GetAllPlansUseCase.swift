//
//  GetAllPlansUseCase.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 27/05/25.
//
import Foundation
import RealmSwift

protocol GetAllPlansUseCase {
    func execute() -> Results<Plan>?
}

// final class GetAllPlansUseCaseImpl: GetAllPlansUseCase {
//    private let plansRepository: PlansRepository
//
//    init(plansRepository: PlansRepository) {
//        self.plansRepository = plansRepository
//    }
//
//    func execute() -> Results<Plan>? {
//        let plans = plansRepository.getAllPlans()
//        return plans
//    }
// }
