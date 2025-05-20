//
//  InputViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//

import UIKit

class InputViewController: UIViewController {
    @IBOutlet var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }

    @objc func submit() {
        print("Submit")
        let categoryView = UIStoryboard(name: "CategorySelectionView", bundle: nil)
        if let targetVC = categoryView.instantiateViewController(withIdentifier: "CategorySelectionView") as? CategorySelectionViewController {
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}
