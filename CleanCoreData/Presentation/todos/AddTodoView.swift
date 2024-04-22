//
//  AddTodoView.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import SwiftUI

struct AddTodoView: View {
    
    private var viewModel: TodoListViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var description: String = ""
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            TextField("Descripción de la tarea", text: $description)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Spacer()
                Button(action: {
                    let _ = viewModel.createNewTodo(desc: description)
                    dismiss()
                }) {
                    Text("Save").frame(maxWidth: 100)
                }.tint(.blue)
                    .buttonStyle(.bordered)
            }
            
            
        }.padding()
    }
}

