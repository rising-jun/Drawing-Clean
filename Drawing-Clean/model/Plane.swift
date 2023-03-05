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
    func tabChangedColorButtonTapped()
    func changedAlpha(with alpha: Float)
}
typealias Plane = BoardActionSendable & PropertyChangeActionSendable

final class PlaneImpl {
    var boardView: BoardView
    var propertyChangeView: PropertyChangeView
    var rectangleFactory: RectangleFactory
    
    private(set) var rectangles = [Rectangle]()
    private(set) var selectedRectangle: Rectangle? {
        willSet(selectRectangle) {
            guard let selectRectangle = selectRectangle else { return }
            boardView.changeViewLayer(selectRectangle: selectRectangle, deselectRectangle: selectedRectangle)
        }
    }
    
    init(boardView: BoardView,
         propertyChangeView: PropertyChangeView,
         rectangleFactory: RectangleFactory) {
        self.boardView = boardView
        self.propertyChangeView = propertyChangeView
        self.rectangleFactory = rectangleFactory
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
}

extension PlaneImpl: BoardActionSendable {
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

extension PlaneImpl: PropertyChangeActionSendable {
    func tabChangedColorButtonTapped() {
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
private extension PlaneImpl {
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
