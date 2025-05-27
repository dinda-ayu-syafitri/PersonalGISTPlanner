//
//  DashboardViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 17/05/25.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet var goalActiveView: UIView!
    @IBOutlet var taskCompleteView: UIView!
    @IBOutlet var taskCompleteProgress: CircularProgressView!
    @IBOutlet var goalCountLabel: UILabel!

    let viewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        updateUI()
    }

    private func setUpView() {
        goalActiveView.layer.borderWidth = 1
        goalActiveView.layer.borderColor = UIColor.blueAccent.cgColor
        taskCompleteView.layer.borderWidth = 1
        taskCompleteView.layer.borderColor = UIColor.blueAccent.cgColor
        taskCompleteProgress.setProgress(0.75)
    }

    private func updateUI() {
        if let plans = viewModel.plans {
            goalCountLabel.text = String(plans.count)
        } else {
            goalCountLabel.text = "0"
        }
    }
}
