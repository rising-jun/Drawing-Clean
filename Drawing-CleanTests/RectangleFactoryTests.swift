//
//  RectangleFactoryTest.swift
//  Drawing-CleanTests
//
//  Created by 김동준 on 2023/02/18.
//

import XCTest
@testable import Drawing_Clean

class RectangleFactoryTests: XCTestCase {

    var rectangleFactory: RectangleFactory!
    
    override func setUpWithError() throws {
        rectangleFactory = RectangleFactory()
    }

    func test_RectangleFactory에서_makeRectangle을_호출하고_생성여부를_확인한다() {
        //give
        var rectangle: Rectangle!
        
        //when
        rectangle =  rectangleFactory.makeRectangle()
        
        //then
        XCTAssert((rectangle != nil))
    }

    func test_RectangleFactory에서_makeRectangle을_호출하고_UniqueID의_형식을_확인한다() {
        //give
        var rectangle: Rectangle!
        let firstHipen = 3
        let secondHipen = 7
        
        //when
        rectangle = rectangleFactory.makeRectangle()
        let uniqueId = rectangle.uniqueName.id
        
        //then
        let firstHipenIndex = uniqueId.index(uniqueId.startIndex, offsetBy: firstHipen)
        let secondHipenIndex = uniqueId.index(uniqueId.startIndex, offsetBy: secondHipen)
        XCTAssert((uniqueId[firstHipenIndex] == "-" && uniqueId[secondHipenIndex] == "-"))
    }
    
    func test_RectangleFactory에서_makeRectangle을_호출하고_color의_유효범위를_확인한다() {
        //give
        var rectangle: Rectangle!
        var color: Color!
        
        //when
        rectangle = rectangleFactory.makeRectangle()
        color = rectangle.color
        
        //then
        let result = (color.r >= 0 && color.r <= 255) && (color.g >= 0 && color.g <= 255) && (color.b >= 0 && color.b <= 255)
        XCTAssert(result)
    }
    
}
