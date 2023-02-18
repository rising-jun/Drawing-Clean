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

    func test_Unique가_randomUnique를_호출하고_형식을_확인한다() {
        //give
        var unique: Unique!
        let firstHipen = 3
        let secondHipen = 7
        
        //when
        unique = Unique.randomUniqueID()
        
        //then
        let firstHipenIndex = unique.id.index(unique.id.startIndex, offsetBy: firstHipen)
        let secondHipenIndex = unique.id.index(unique.id.startIndex, offsetBy: secondHipen)
        XCTAssert((unique.id[firstHipenIndex] == "-" && unique.id[secondHipenIndex] == "-"))
    }
    
    func test_Color가_randomColor를_호출하고_유효범위를_확인한다() {
        //give
        var color: Color!
        
        //when
        color = Color.randomColor()
        
        //then
        let result = (color.r >= 0 && color.r <= 255) && (color.g >= 0 && color.g <= 255) && (color.b >= 0 && color.b <= 255)
        XCTAssert(result)
    }
    
}
