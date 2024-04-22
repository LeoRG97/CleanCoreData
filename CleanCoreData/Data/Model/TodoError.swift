//
//  TodoError.swift
//  CleanCoreData
//
//  Created by Leonardo Rodríguez González on 22/04/24.
//


/*
 Clase para enumerar los tipos de errores en la aplicación
 */
import Foundation


enum TodoError: Error {
    case DataSourceError, CreateError, DeleteError, UpdateError, FetchError
}
