//
//  Plane.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/19.
//

import Foundation

protocol BoardActionSendable {
    func boardTapped(point: Point)
    func makeRectangleButtonTapped()
}
protocol PropertyChangeActionSendable {
    func tabChangedColorButton()
    func changedAlpha(with alpha: Float)
}

final class Plane {
    var boardView: BoardView
    var propertyChangeView: PropertyChangeView
    
    private var rectangles = [Rectangle]()
    private var selectedRectangle: Rectangle? {
        willSet(selectRectangle) {
            guard let selectRectangle = selectRectangle else { return }
            boardView.changeViewLayer(selectRectangle: selectRectangle, deselectRectangle: selectedRectangle)
        }
    }
    private var rectangleFactory = RectangleFactory()
    
    init(boardView: BoardView, propertyChangeView: PropertyChangeView) {
        self.boardView = boardView
        self.propertyChangeView = propertyChangeView
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
}

extension Plane: BoardActionSendable {
    func boardTapped(point: Point) {
        self.selectedRectangle = veryfyIsRectangleRange(by: point)
        guard let selectedRectangle = selectedRectangle else { return }
        propertyChangeView.setAttributeChangeViewToSelectedRectangle(with: selectedRectangle)
    }
    
    func makeRectangleButtonTapped() {
        makeRandomRectangle()
        boardView.addRectangleToBoard(rectangle: rectangles[checkRectangleCount() - 1])
    }
}

extension Plane: PropertyChangeActionSendable {
    func tabChangedColorButton() {
        selectedRectangle?.changeColor()
        updateSelectedView()
    }
    
    func changedAlpha(with alpha: Float) {
        var value = alpha * 10
        value.round()
        value /= 10.0
        selectedRectangle?.changeAlpha(with: Double(value))
        updateSelectedView()
    }
}
private extension Plane {
    func checkRectangleCount() -> Int {
        return rectangles.count
    }

    func makeRandomRectangle() {
        self.rectangles.append(rectangleFactory.makeRectangle())
    }

    func veryfyIsRectangleRange(by point: Point) -> Rectangle? {
        for rectangle in rectangles.reversed() {
            if rectangle.veryfyIsRectangleRange(by: point) {
                return rectangle
            }
        }
        return nil
    }
    
    func updateSelectedView() {
        guard let selectedRectangle = self.selectedRectangle else { return }
        propertyChangeView.setAttributeChangeViewToSelectedRectangle(with: selectedRectangle)
        boardView.changeViewColor(selected: selectedRectangle)
    }
}
