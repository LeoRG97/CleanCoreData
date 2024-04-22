//
//  TodoRepository.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

/*
 Recuerda que un repository se comunica con el DarasOURCE
 */
import Foundation

struct TodoRepositoryImpl: TodoRepository {
    
    var dataSource: TodoDataSource
    
    func getTodos() -> Result<[Todo], TodoError> {
        do {
            let _todos = try dataSource.getAll()
            return .success(_todos)
        } catch {
            return .failure(.FetchError)
        }
    }
    
    func getTodo(id: UUID) async -> Result<Todo?, TodoError> {
        do {
            let _todo = try await dataSource.getById(id)
            return .success(_todo)
        } catch {
            return .failure(.FetchError)
        }
    }
    
    func deleteTodo(_ id: UUID) -> Result<Bool, TodoError> {
        do {
            try dataSource.delete(id)
            return .success(true)
        } catch {
            return .failure(.DeleteError)
        }
    }
    
    func createTodo(_ todo: Todo) -> Result<Bool, TodoError> {
        
        print("NUEVA", todo)
        do {
            try dataSource.create(todo: todo)
            return .success(true)
        } catch {
            return .failure(.CreateError)
        }
    }
    
    func updateTodo(_ todo: Todo) async -> Result<Bool, TodoError> {
        do {
            try await dataSource.update(id: todo.id, todo: todo)
            return .success(true)
        } catch {
            return .failure(.UpdateError)
        }
    }
    
    
}
