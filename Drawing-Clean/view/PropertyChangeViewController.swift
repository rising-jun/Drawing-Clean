//
//  AttributeChangeViewController.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/19.
//

import UIKit

final class PropertyChangeViewController: UIViewController {
    private var plane: Plane?
    
    private let backgroundColorLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 30.0, y: 30.0, width: 100, height: 40))
        label.text = "배경색"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let colorChangeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 30, y: 80, width: 200, height: 60))
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10.0
        button.setTitle("#??????", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let alphaLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 30.0, y: 150.0, width: 100, height: 40))
        label.text = "투명도"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let alphaChangeSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 30, y: 200, width: 200, height: 30))
        slider.minimumValue = 0.1
        slider.maximumValue = 1.0
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAttribute()
    }
    
    static func create() -> PropertyChangeViewController {
        return PropertyChangeViewController()
    }
}
extension PropertyChangeViewController {
    func setPlane(plane: Plane) {
        self.plane = plane
    }
    
    func setAttributeChangeViewToSelectedRectangle(with rectangle: Rectangle) {
        setColorButtonLabel(with: rectangle.color.description)
        setAlphaLabel(with: rectangle.alpha.description)
    }
}

private extension PropertyChangeViewController {
    func viewAttribute() {
        view.backgroundColor = .systemGray4
        view.addSubview(backgroundColorLabel)
        view.addSubview(colorChangeButton)
        view.addSubview(alphaLabel)
        view.addSubview(alphaChangeSlider)
        
        colorChangeButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.plane?.tabChangedColorButton()
        }), for: .touchDown)
        
        alphaChangeSlider.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.plane?.changedAlpha(with: self.alphaChangeSlider.value)
        }), for: .touchDragInside)
    }
    
    func setColorButtonLabel(with rgb: String) {
        colorChangeButton.setTitle(rgb, for: .normal)
    }
    
    func setAlphaLabel(with alpha: String) {
        let startIdx: String.Index = alpha.index(alpha.startIndex, offsetBy: 2)
        alphaLabel.text = (alpha[startIdx] == "0" ? "10" : String(alpha[startIdx]))
        alphaChangeSlider.setValue(Float(alpha) ?? 0.0, animated: false)
    }
}
