//
//  DeleteTodo.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

protocol DeleteTodo {
    func invoke(id: UUID) -> Bool
}

struct DeleteTodoUseCase: DeleteTodo {
    
    private var todoRepository: TodoRepository
    
    init(todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }
    
    func invoke(id: UUID) -> Bool {
        let result = todoRepository.deleteTodo(id)
        
        do {
            let success = try result.get()
            return success
        } catch {
            return false
        }
        
    }
    
}
