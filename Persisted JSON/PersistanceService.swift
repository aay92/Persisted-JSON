//
//  PersistanceService.swift
//  Persisted JSON
//
//  Created by Aleksey Alyonin on 10.04.2023.
//

import Foundation
import CoreData

class PersistenceService {
    
    private init(){}
    static let shared = PersistenceService()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Persisted_JSON")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func save(completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func removed() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        do {
            try context.save()
        } catch {
        }

        
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
           let object = try context.fetch(request)
            completion(object)
        } catch {
            print("error in update date: \(error)")
            completion([])
        }
    }

}
