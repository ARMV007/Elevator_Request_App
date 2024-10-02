//
//  ElevatorView.swift
//  Elevator Request App
//
//  Created by Abhishek on 02/10/24.
//

import SwiftUI

struct ElevatorView: View {
    
    @ObservedObject var elevatorViewModel = ElevatorViewModel()
    
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
                                .font(.system(size: 25, weight: .bold)) // Increase the font size
                                .frame(width: 100, height: 50)
                                .foregroundColor(.white) // Icon color
                                .background(Color.blue) // Button background color
                                .cornerRadius(10) // Button corner radius
                        }
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
                    .font(.system(size: 25, weight: .bold)) // Increase the font size
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white) // Icon color
                    .background(Color.blue) // Button background color
                    .cornerRadius(10) // Button corner radius
            }
            .padding()
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
