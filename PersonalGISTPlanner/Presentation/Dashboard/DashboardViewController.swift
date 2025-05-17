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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView() {
        goalActiveView.layer.borderWidth = 1
        goalActiveView.layer.borderColor = UIColor.blueAccent.cgColor
        taskCompleteView.layer.borderWidth = 1
        taskCompleteView.layer.borderColor = UIColor.blueAccent.cgColor
    }
}
