//
//  TodoCoreDataSourceImpl.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//

import Foundation
import CoreData

struct TodoCoreDataSourceImpl: TodoDataSource {
    
    /*
     MARK: PATRÓN SINGLETON
     Solamente una instancia por ejecución de la app
     */
    static let shared = TodoCoreDataSourceImpl()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "CleanCoreData")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError("Cannot Load Core Data Model")
            }
        }
    }
    
    func getAll() throws -> [Todo] {
        
        let request = TodoCoreDataEntity.fetchRequest()
        return try container.viewContext.fetch(request).map { todoEntity in
            Todo(
                id: todoEntity.id!,
                title: todoEntity.title!,
                isCompleted: todoEntity.is_completed
            )
        }
        
    }
    
    func getById(_ id: UUID) async throws -> Todo? {
        /*
         el struct "Todo" se utiliza para mapear la entidad de CoreData a una entidad de Swift
         */
        let todoCoreDataEntity = try getEntityById(id)!
        return Todo(
            id: todoCoreDataEntity.id!,
            title: todoCoreDataEntity.title!,
            isCompleted: todoCoreDataEntity.is_completed
        )
    }
    
    func delete(_ id: UUID) throws {
        let todoCoreDataEntity = try getEntityById(id)!
        let context = container.viewContext
        context.delete(todoCoreDataEntity)
        do {
            try context.save()
        } catch let error as NSError {
            fatalError("Error in delete op: \(error.localizedDescription)")
        }
    }
    
    func create(todo: Todo) throws {
        let todoCoreDataEntity = TodoCoreDataEntity(context: container.viewContext)
        todoCoreDataEntity.is_completed = todo.isCompleted
        todoCoreDataEntity.title = todo.title
        todoCoreDataEntity.id = todo.id
        saveContext()
    }
    
    func update(id: UUID, todo: Todo) async throws {
        let todoCoreDataEntity = try getEntityById(id)!
        todoCoreDataEntity.is_completed = todo.isCompleted
        todoCoreDataEntity.title = todo.title
        saveContext()
    }
    
    private func getEntityById(_ id: UUID)  throws  -> TodoCoreDataEntity?{
           let request = TodoCoreDataEntity.fetchRequest()
           request.fetchLimit = 1
           request.predicate = NSPredicate(
               format: "id = %@", id.uuidString)
           let context =  container.viewContext
           let todoCoreDataEntity = try context.fetch(request)[0]
           return todoCoreDataEntity
           
       }
       
       private func saveContext(){
           // FUNCIÓN PARA GUARDAR CAMBIOS
           let context = container.viewContext
           if context.hasChanges {
               do{
                   try context.save()
               }catch{
                   fatalError("Error: \(error.localizedDescription)")
               }
           }
       }
    
    
}
