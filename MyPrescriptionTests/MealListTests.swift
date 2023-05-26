//
//  MealListTests.swift
//  MyPrescriptionTests
//
//  Created by Stefan Jivalino on 26/05/23.
//

@testable import MyPrescription
import XCTest

class MealListTests: XCTestCase {
    var viewModel: MealListViewModel!
    var mockedService: MealListMockService!
    
    override func setUp() {
        mockedService = MealListMockService()
        viewModel = .init(withMealList: mockedService)
    }
    
    func testGetMealList() {
        viewModel.getMealList(search: "a")
        if viewModel.mealData.meals?.count ?? 0 > 0 {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
    
    func testAsyncGetMealList()  {
        var meal = MealListModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.viewModel.getMealList(search: "a")
            meal = self.viewModel.mealData
            XCTAssertTrue(meal.meals?.count ?? 0 > 0)
        }
        
        
        
        
        
    }
    
}
