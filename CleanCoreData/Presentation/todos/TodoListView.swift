//
//  TodoListView.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject private var viewModel: TodoListViewModel
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            
            if viewModel.isLoadingData {
                ProgressView().progressViewStyle(.circular)
            } else {
                List {
                    ForEach(viewModel.todos) {item in
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title).font(.title2)
                                    .foregroundStyle(.black)
                                Text(item.isCompleted ? "Completada" : "Pendiente")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        
                        }.swipeActions(allowsFullSwipe: false) {
                            
                            Button(action: {
                                withAnimation {
                                    print("Eliminar")
                                    viewModel.deleteTodo(id: item.id)
                                }
                                
                            }) {
                                Label("Eliminar", systemImage: "trash.fill")
                            }.tint(.red)
                            
                        }
                        
                    }
                }
            }
            
        }.onAppear{
            viewModel.getTodos()
        }.navigationTitle("Todo List")
            .toolbar {
                NavigationLink(destination: AddTodoFactory.create()) {
                    Image(systemName: "note.text")
                }
            }
        
    }
}
