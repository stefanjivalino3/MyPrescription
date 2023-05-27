//
//  MealDetailTests.swift
//  MyPrescriptionTests
//
//  Created by Stefan Jivalino on 27/05/23.
//

import XCTest
@testable import MyPrescription

final class MealDetailTests: XCTestCase {
    var viewModel: MealDetailViewModel!
    var mockedService: MealDetailMockService!
    
    override func setUp() {
        mockedService = MealDetailMockService()
        viewModel = .init(withMealDetail: mockedService)
    }
    
    func testGetMealDetail() {
        viewModel.getMealDetail(id: "1")
        if viewModel.mealDetailData.meals?.count == 1 {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
    
    func testAsyncGetMealDetail()  {
        var meal = MealDetailModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.viewModel.getMealDetail(id: "1")
            meal = self.viewModel.mealDetailData
            XCTAssertTrue(meal.meals?.count ?? 0 > 0)
        }
        
        
        
        
        
    }

}
