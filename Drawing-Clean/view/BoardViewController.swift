//
//  ViewController.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/18.
//

import UIKit

class BoardViewController: UIViewController {
    private var plane: Plane?
    private var rectangleViews = [Rectangle: UIView]()
    
    private let addRectangleButton: UIButton = {
        let buttonSize = Size(width: 120.0, height: 60.0)
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX / 2 - (buttonSize.width / 2), y: UIScreen.main.bounds.maxY - buttonSize.height - 44, width: buttonSize.width, height: buttonSize.height))
        button.setImage(UIImage(systemName: "rectangle"), for: .normal)
        button.largeContentImageInsets = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
        button.layer.borderWidth = 1
        return button
    }()
    
    static func create() -> BoardViewController {
        return BoardViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAttribute()
        registerAddRectangleButtonAction()
    }
    
    @objc func viewDidTap(_ sender: UITapGestureRecognizer) {
        let x = sender.location(in: self.view).x
        let y = sender.location(in: self.view).y
        plane?.boardTapped(point: Point(x: x, y: y))
    }
    
    func setPlane(plane: Plane) {
        self.plane = plane
    }
}
extension BoardViewController {
    func addRectangleToBoard(rectangle: Rectangle) {
        addRectangleToBoard(with: rectangle)
    }
    
    func changeViewLayer(selectRectangle: Rectangle, deselectRectangle: Rectangle?) {
        selectedRectangle(rectangle: selectRectangle)
        guard let deselectRectangle = deselectRectangle else { return }
        deselectedRectangle(rectangle: deselectRectangle)
    }
    
    func changeViewColor(selected rectangle: Rectangle) {
        guard let selectedView = rectangleViews[rectangle] else { return }
        selectedView.backgroundColor = UIColor(red: CGFloat(rectangle.color.r) / 255,
                                               green: CGFloat(rectangle.color.g) / 255,
                                               blue: CGFloat(rectangle.color.b) / 255,
                                               alpha: rectangle.alpha.value)
    }
}

private extension BoardViewController {
    private func viewAttribute() {
        view.backgroundColor = .white
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
        view.addSubview(addRectangleButton)
    }
    
    private func registerAddRectangleButtonAction() {
        addRectangleButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.plane?.makeRectangleButtonTapped()
        }), for: .touchUpInside)
    }
    
    private func addRectangleToBoard(with rectangle: Rectangle) {
        let rectangleView = UIView(frame: CGRect(x: rectangle.point.x,
                                                 y: rectangle.point.y,
                                                 width: rectangle.size.width,
                                                 height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(red: CGFloat(rectangle.color.r) / 255,
                                                green: CGFloat(rectangle.color.g) / 255,
                                                blue: CGFloat(rectangle.color.b) / 255,
                                                alpha: rectangle.alpha.value)
        view.addSubview(rectangleView)
        rectangleViews[rectangle] = rectangleView
    }
    
    private func selectedRectangle(rectangle: Rectangle) {
        guard let rectangleView = rectangleViews[rectangle] else { return }
        rectangleView.layer.borderWidth = 2.0
        rectangleView.layer.borderColor = UIColor.black.cgColor
        rectangleView.bringSubviewToFront(self.view)
    }
    
    private func deselectedRectangle(rectangle: Rectangle) {
        guard let rectangleView = rectangleViews[rectangle] else { return }
        rectangleView.layer.borderWidth = 0.0
    }
}
