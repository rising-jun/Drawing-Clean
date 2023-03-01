//
//  SplitViewController.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/19.
//

import UIKit

final class SplitViewController: UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.primaryEdge = .trailing
        preferredPrimaryColumnWidthFraction = 0.2
        let boardViewController = BoardViewController.create()
        let propertyChangeViewController = PropertyChangeViewController.create()
        let plane = Plane(boardView: boardViewController, propertyChangeView: propertyChangeViewController)
        boardViewController.setPlane(plane: plane)
        propertyChangeViewController.setPlane(plane: plane)
        self.viewControllers = [propertyChangeViewController, boardViewController]
    }
}

