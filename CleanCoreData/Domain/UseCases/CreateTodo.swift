//
//  CreateTodo.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

protocol CreateTodo {
    func invoke(desc: String) -> Bool
}

struct CreateTodoUseCase: CreateTodo {
    
    private var todoRepository: TodoRepository
    
    init(todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }
    
    func invoke(desc: String) -> Bool {
        
        let newTodo = Todo(id: UUID(), title: desc, isCompleted: false)
        
        let result = todoRepository.createTodo(newTodo)
        
        do {
            let success = try result.get()
            return success
        } catch {
            return false
        }
        
    }
    
}
