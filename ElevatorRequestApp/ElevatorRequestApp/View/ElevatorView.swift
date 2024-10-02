//
//  ElevatorView.swift
//  Elevator Request App
//
//  Created by Abhishek on 02/10/24.
//

import SwiftUI

struct ElevatorView: View {
    
    @ObservedObject var elevatorViewModel = ElevatorViewModel(elevator: Elevator(currentFloor: 0, direction: .idle, topFloor: 5, bottomFloor: -2))

    var body: some View {
        VStack(spacing: 20) {
            // Display Current Floor and Direction
            Text("Current Floor: \(elevatorViewModel.elevator.currentFloor)")
                .font(.largeTitle)
            
            // Down Button
            Button(action: {
                elevatorViewModel.requestElevator(direction: .up) // Request elevator
            }) {
                Image(systemName: "chevron.up") // SF Symbol
            }
            .modifier(ElevatorButtonStyleModifier(backgroundColor: elevatorViewModel.canMoveUp ? .blue : .gray))
            .disabled(!elevatorViewModel.canMoveUp)// Apply custom modifier
            .padding()
            
            HStack(spacing: 10) {
                //Display Current Direction and Loading
                Text(directionText(elevatorViewModel.elevator.direction))
                    .font(.title2)
                    .foregroundColor(elevatorViewModel.elevator.direction == .idle ? .green : .blue)
                
                // Loading Indicator (when moving)
                if elevatorViewModel.isMoving {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            
            // Down Button
            Button(action: {
                elevatorViewModel.requestElevator(direction: .down)
            }) {
                Image(systemName: "chevron.down") // SF Symbol
            }
            .modifier(ElevatorButtonStyleModifier(backgroundColor: elevatorViewModel.canMoveDown ? .blue : .gray)) // Apply custom modifier
            .disabled(!elevatorViewModel.canMoveDown)
            .padding()
            
            // for Demo
            Text("Top Floor: \(elevatorViewModel.elevator.topFloor)")
                .font(.title3)
            Text("Bottom Floor: \(elevatorViewModel.elevator.bottomFloor)")
                .font(.title3)
        }
    }
    
    // Helper method to convert direction enum to text
    func directionText(_ direction: ElevatorDirection) -> String {
        switch direction {
        case .up:
            return "Going Up"
        case .down:
            return "Going Down"
        case .idle:
            return "Idle"
        }
    }
}

struct ElevatorView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorView()
    }
}
