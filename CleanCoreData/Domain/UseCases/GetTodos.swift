//
//  GetTodos.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

protocol GetTodos {
    func invoke() -> [Todo]
}

struct GetTodosUseCase: GetTodos {
    
    private var todoRepository: TodoRepository
    
    init(todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }
    
    func invoke() -> [Todo] {
        
        let result = todoRepository.getTodos()
        
        do {
            let todos = try result.get()
            return todos
        } catch {
            return []
        }
        
        
    }
    
}
