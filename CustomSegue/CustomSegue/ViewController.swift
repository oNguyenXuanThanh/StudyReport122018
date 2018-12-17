//
//  ViewController.swift
//  CustomSegue
//
//  Created by Thanh Nguyen Xuan on 12/17/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else {
            return
        }
        let rootViewController = navigationController.viewControllers.first
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hide))
        rootViewController?.navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func hide() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func showProgrammaticallyButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Init view controller cần present
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationController")
        // Tạo custom instance của BottomCardSegue và set destination view controller
        let segue = BottomCardSegue(identifier: nil, source: self, destination: navigationController)
        // Gọi function prepare segue nếu cần
        prepare(for: segue, sender: nil)
        // Perform segue
        segue.perform()
    }

}

