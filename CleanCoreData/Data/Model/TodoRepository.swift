//
//  TodoRepository.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

protocol TodoRepository {
    func getTodos() -> Result<[Todo], TodoError>
    func getTodo(id: UUID) async -> Result<Todo?, TodoError>
    func deleteTodo(_ id: UUID) -> Result<Bool, TodoError>
    func createTodo(_ todo: Todo) -> Result<Bool, TodoError>
    func updateTodo(_ todo: Todo) async -> Result<Bool, TodoError>
}
