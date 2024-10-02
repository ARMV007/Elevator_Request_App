//
//  ElevatorRequestAppUITests.swift
//  ElevatorRequestAppUITests
//
//  Created by Abhishek on 02/10/24.
//

import XCTest

final class ElevatorRequestAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Set up code before each test method in the class
        continueAfterFailure = false // Stop immediately when a failure occurs
    }

    override func tearDownWithError() throws {
        // Tear down code after each test method in the class
    }

    func testElevatorMovementUp() throws {
        let app = XCUIApplication()
        app.launch()

        // Assert initial state
        XCTAssertTrue(app.staticTexts["Current Floor: 0"].exists)

        // Tap the up button
        app.buttons["upButton"].tap()

        // Wait for the elevator to move to the next floor
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.staticTexts["Current Floor: 1"])
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)

        // Assert the elevator has moved up
        XCTAssertEqual(result, .completed)
        XCTAssertTrue(app.staticTexts["Current Floor: 1"].exists)
    }

    func testElevatorMovementDown() throws {
        let app = XCUIApplication()
        app.launch()

        // Move the elevator up to floor 1 first
        app.buttons["upButton"].tap()
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.staticTexts["Current Floor: 1"])
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)

        // Assert initial state on floor 1
        XCTAssertTrue(app.staticTexts["Current Floor: 1"].exists)

        // Tap the down button
        app.buttons["downButton"].tap()

        // Wait for the elevator to move to the previous floor
        let downExpectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.staticTexts["Current Floor: 0"])
        let result = XCTWaiter.wait(for: [downExpectation], timeout: 5.0)

        // Assert the elevator has moved down
        XCTAssertEqual(result, .completed)
        XCTAssertTrue(app.staticTexts["Current Floor: 0"].exists)
    }
    
    func testButtonsDisabledOnTopAndBottomFloors() throws {
        let app = XCUIApplication()
        app.launch()

        // Move to the top floor
        for _ in 0..<5 {
            app.buttons["upButton"].tap()

            // Wait for the elevator to move up one floor
            let currentFloorLabel = app.staticTexts["currentFloorLabel"].label
            let currentFloor = Int(currentFloorLabel.replacingOccurrences(of: "Current Floor: ", with: "")) ?? 0
            let expectedNextFloor = currentFloor + 1

            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.staticTexts["Current Floor: \(expectedNextFloor)"])
            _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        }

        // Assert that the up button is disabled on the top floor
        XCTAssertFalse(app.buttons["upButton"].isEnabled)

        // Move to the bottom floor
        for _ in -2..<5 {
            app.buttons["downButton"].tap()

            // Wait for the elevator to move down one floor
            let currentFloorLabel = app.staticTexts["currentFloorLabel"].label
            let currentFloor = Int(currentFloorLabel.replacingOccurrences(of: "Current Floor: ", with: "")) ?? 5
            let expectedNextFloor = currentFloor - 1

            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.staticTexts["Current Floor: \(expectedNextFloor)"])
            _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        }

        // Assert that the down button is disabled on the bottom floor
        XCTAssertFalse(app.buttons["downButton"].isEnabled)
    }


}
