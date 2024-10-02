//
//  ElevatorViewModelTests.swift
//  ElevatorRequestAppTests
//
//  Created by Abhishek on 02/10/24.
//

import XCTest
@testable import ElevatorRequestApp

final class ElevatorViewModelTests: XCTestCase {
    var elevator: Elevator!
    var elevatorViewModel: ElevatorViewModel!

    override func setUp() {
        super.setUp()
        elevator = Elevator(currentFloor: 0, direction: .idle, topFloor: 5, bottomFloor: 0)
        elevatorViewModel = ElevatorViewModel(elevator: elevator)
    }

    override func tearDown() {
        elevatorViewModel = nil
        elevator = nil
        super.tearDown()
    }

    func testInitialSetup() {
        XCTAssertEqual(elevatorViewModel.elevator.currentFloor, 0)
        XCTAssertEqual(elevatorViewModel.elevator.topFloor, 5)
        XCTAssertEqual(elevatorViewModel.elevator.bottomFloor, 0)
        XCTAssertFalse(elevatorViewModel.isMoving)
    }

    func testCanMoveUp() {
        elevatorViewModel.elevator.currentFloor = 0
        XCTAssertTrue(elevatorViewModel.canMoveUp)

        elevatorViewModel.elevator.currentFloor = 5
        XCTAssertFalse(elevatorViewModel.canMoveUp)
    }

    func testCanMoveDown() {
        elevatorViewModel.elevator.currentFloor = 5
        XCTAssertTrue(elevatorViewModel.canMoveDown)

        elevatorViewModel.elevator.currentFloor = 0
        XCTAssertFalse(elevatorViewModel.canMoveDown)
    }

    func testRequestElevatorMovesUp() {
        elevatorViewModel.elevator.currentFloor = 0
        elevatorViewModel.requestElevator(direction: .up)
        
        // Allow some time for the elevator to move
        let expectation = self.expectation(description: "Elevator should move up to floor 1")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            XCTAssertEqual(self.elevatorViewModel.elevator.currentFloor, 1)
            XCTAssertEqual(self.elevatorViewModel.elevator.direction, .idle)
            XCTAssertFalse(self.elevatorViewModel.isMoving)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }

    func testRequestElevatorMovesDown() {
        elevatorViewModel.elevator.currentFloor = 5
        elevatorViewModel.requestElevator(direction: .down)
        
        // Allow some time for the elevator to move
        let expectation = self.expectation(description: "Elevator should move down to floor 4")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            XCTAssertEqual(self.elevatorViewModel.elevator.currentFloor, 4)
            XCTAssertEqual(self.elevatorViewModel.elevator.direction, .idle)
            XCTAssertFalse(self.elevatorViewModel.isMoving)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
}
