//
//  PlaneTests.swift
//  Drawing-CleanTests
//
//  Created by 김동준 on 2023/03/04.
//

import XCTest
@testable import Drawing_Clean

class PlaneTests: XCTestCase {
    var plane: PlaneImpl!
    
    func test_Plane에서_makeRectangleButtonTapped를_호출하고_rectangle의_생성여부를_검증하고_성공한다() {
        //give
        plane = PlaneImpl(boardView: BoardViewController(),
                          propertyChangeView: PropertyChangeViewController(),
                          rectangleFactory: RectangleFactoryStub())
        
        //when
        plane.makeRectangleButtonTapped()
        
        //then
        XCTAssert((plane.rectangles.count > 0))
    }
    
    func test_Plane에서_tabChangedColorButton를_호출하고_rectangle의_좌표선택_시_사각형이_선택되고_성공한다() {
        //give
        plane = PlaneImpl(boardView: BoardViewController(),
                          propertyChangeView: PropertyChangeViewController(),
                          rectangleFactory: RectangleFactoryStub())
        plane.makeRectangleButtonTapped()
        
        //when
        plane.boardTapped(point: Point(x: 0.0, y: 0.0))
        
        //then
        XCTAssert((plane.selectedRectangle != nil))
    }
    
    func test_Plane에서_tabChangedColorButton를_호출하고_rectangle의_좌표선택_시_사각형_선택이_실패되고_성공한다() {
        //give
        plane = PlaneImpl(boardView: BoardViewController(),
                          propertyChangeView: PropertyChangeViewController(),
                          rectangleFactory: RectangleFactoryStub())
        plane.makeRectangleButtonTapped()
        
        //when
        plane.boardTapped(point: Point(x: 999.0, y: 999.0))
        
        //then
        XCTAssert((plane.selectedRectangle == nil))
    }
    
    func test_Plane에서_tabChangedColorButtonTapped를_호출하고_선택된_rectangle의_색상이_변화했는지_검증하고_성공한다() {
        //give
        plane = PlaneImpl(boardView: BoardViewController(),
                          propertyChangeView: PropertyChangeViewController(),
                          rectangleFactory: RectangleFactoryStub())
        plane.makeRectangleButtonTapped()
        plane.boardTapped(point: Point(x: 0.0, y: 0.0))
        let color = plane.selectedRectangle!.color
        
        //when
        plane.tabChangedColorButtonTapped()
        let newColor = plane.selectedRectangle!.color
        
        //then
        XCTAssert(color != newColor)
    }
    
    func test_Plane에서_tchangedAlpha를_호출하고_선택된_rectangle의_alpha이_변화했는지_검증하고_성공한다() {
        //give
        plane = PlaneImpl(boardView: BoardViewController(),
                          propertyChangeView: PropertyChangeViewController(),
                          rectangleFactory: RectangleFactoryStub())
        plane.makeRectangleButtonTapped()
        plane.boardTapped(point: Point(x: 0.0, y: 0.0))
        let alpha = plane.selectedRectangle!.alpha
        
        //when
        plane.changedAlpha(with: 0.1)
        let newAlpha = plane.selectedRectangle!.alpha
        
        //then
        XCTAssert(alpha != newAlpha)
    }
}
