//
//  Todo.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

struct Todo: Identifiable {
    let id: UUID
    let title: String
    let isCompleted: Bool
}
