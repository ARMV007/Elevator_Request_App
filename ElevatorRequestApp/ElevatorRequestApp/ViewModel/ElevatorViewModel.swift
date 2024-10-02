//
//  ElevatorViewModel.swift
//  Elevator Request App
//
//  Created by Abhishek on 02/10/24.
//

import Foundation

class ElevatorViewModel: ObservableObject {
    @Published var elevator = Elevator(currentFloor: 0, direction: .idle)
    @Published var isMoving = false
    
    // Simulate delay for elevator movement
    func moveElevator(to destinationFloor: Int) {
        guard !isMoving else { return }
        
        isMoving = true
        
        // Check the direction for elevator movement
        let direction: ElevatorDirection = (destinationFloor > elevator.currentFloor) ? .up : .down
        elevator.direction = direction
        
        // Simulate movement with delay
        let stepTime = 1.0
        let totalSteps = abs(destinationFloor - elevator.currentFloor)
        
        for step in 1...totalSteps {
            DispatchQueue.main.asyncAfter(deadline: .now() + (stepTime * Double(step))) {
                if self.elevator.direction == .up {
                    self.elevator.currentFloor += 1
                } else if self.elevator.direction == .down {
                    self.elevator.currentFloor -= 1
                }
                
                // Update direction when reaching the destination
                if self.elevator.currentFloor == destinationFloor {
                    self.elevator.direction = .idle
                    self.isMoving = false
                }
            }
        }
    }
    
    func requestElevator(direction: ElevatorDirection) {
        let destinationFloor = direction == .up ? elevator.currentFloor + 1 : elevator.currentFloor - 1
        moveElevator(to: destinationFloor)
    }
}
