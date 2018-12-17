//
//  BottomCardSegue.swift
//  CustomSegue
//
//  Created by Thanh Nguyen Xuan on 12/17/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class BottomCardSegue: UIStoryboardSegue {

    private var selfRetainer: BottomCardSegue? = nil

    override func perform() {
        destination.transitioningDelegate = self
        selfRetainer = self
        destination.modalPresentationStyle = .overCurrentContext
        source.present(destination, animated: true, completion: nil)
    }

}

extension BottomCardSegue: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Presenter()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Dismisser()
    }

}

private class Presenter: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                return
        }

        // Set constraint cho presenting view
        toView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(toView)
        let bottom = max(20 - toView.safeAreaInsets.bottom, 0)
        container.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: bottom).isActive = true
        container.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: -20).isActive = true
        container.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: 20).isActive = true
        if toViewController.preferredContentSize.height > 0 {
            toView.heightAnchor.constraint(equalToConstant: toViewController.preferredContentSize.height).isActive = true
        }

        // Styling presenting view
        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20

        // Thực hiện các animation của transition
        container.layoutIfNeeded()
        let originalOriginY = toView.frame.origin.y
        toView.frame.origin.y += container.frame.height - toView.frame.minY
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            toView.frame.origin.y = originalOriginY
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}

private class Dismisser: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            fromView.frame.origin.y += container.frame.height - fromView.frame.minY
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }

}
