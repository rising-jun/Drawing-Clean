//
//  ViewController.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rectangleFactory = RectangleFactory()
        for i in 0...4 {
            print("rectangle\(i) : \(rectangleFactory.makeRectangle())")
        }
    }

}

