//
//  AddTodoFactory.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

class AddTodoFactory {
    
    static func create() -> AddTodoView {
        return AddTodoView(viewModel: createViewModel())
    }
    
    private static func createViewModel() -> TodoListViewModel {
        return TodoListViewModel(
            getTodosUseCase: createGetTodosUseCase(),
            createTodoUseCase: createCreateTodoUseCase(),
            deleteTodoUseCase: createDeleteTodoUseCase()
        )
    }
    
    private static func createDeleteTodoUseCase() -> DeleteTodo {
        return DeleteTodoUseCase(todoRepository: createTodoRepository())
    }
    
    private static func createCreateTodoUseCase() -> CreateTodo {
        return CreateTodoUseCase(todoRepository: createTodoRepository())
    }
    
    private static func createGetTodosUseCase() -> GetTodos {
        return GetTodosUseCase(todoRepository: createTodoRepository())
    }
    
    private static func createTodoRepository() -> TodoRepository {
        return TodoRepositoryImpl(dataSource: TodoCoreDataSourceImpl.shared)
    }

    
}
