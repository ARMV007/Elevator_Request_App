//
//  Elevator.swift
//  Elevator Request App
//
//  Created by Abhishek on 02/10/24.
//

import Foundation

enum ElevatorDirection {
    case up, down, idle
}

struct Elevator {
    var currentFloor: Int
    var direction: ElevatorDirection
    var topFloor: Int
    var bottomFloor: Int
}
