//
//  TodoListViewModel.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    private let getTodosUseCase: GetTodos
    private let createTodoUseCase: CreateTodo
    private let deleteTodoUseCase: DeleteTodo
    
    @Published var todos: [Todo] = []
    @Published var isLoadingData: Bool = false
    
    init(
        getTodosUseCase: GetTodos,
        createTodoUseCase: CreateTodo,
        deleteTodoUseCase: DeleteTodo
    ) {
        self.getTodosUseCase = getTodosUseCase
        self.createTodoUseCase = createTodoUseCase
        self.deleteTodoUseCase = deleteTodoUseCase
    }
    
    func getTodos() {
        isLoadingData = true
        let todoList = getTodosUseCase.invoke()
        self.todos.removeAll()
        self.todos.append(contentsOf: todoList)
        isLoadingData = false
    }
    
    func createNewTodo(desc: String) -> Bool {
        let result = createTodoUseCase.invoke(desc: desc)
        return result
    }
    
    func deleteTodo(id: UUID) -> Void {
        let result = deleteTodoUseCase.invoke(id: id)
        if (result) {
            let updatedTodos = self.todos.filter { item in
                item.id != id
            }
            self.todos.removeAll()
            self.todos.append(contentsOf: updatedTodos)
        }
  
    }
    
}
