//
//  TodoDataSource.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation

protocol TodoDataSource {
    func getAll() throws -> [Todo]
    func getById(_ id: UUID) async throws -> Todo?
    func delete(_ id: UUID) throws -> ()
    func create(todo: Todo) throws -> ()
    func update(id: UUID, todo: Todo) async throws -> ()
}
