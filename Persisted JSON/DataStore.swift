//
//  DataStore.swift
//  Persisted JSON
//
//  Created by Aleksey Alyonin on 17.04.2023.
//

import Foundation
import CoreData

class DataStore : NSObject {
    
    let persistence = PersistenceService.shared
    let networking = NetworkingService.shared
    
    private override init() {
        super.init()
    }
    static let shared = DataStore()
        
    func request(completion: @escaping ([User]) -> Void) {
        
        networking.request("https://api.publicapis.org/entries") {[weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    let entries = try JSONDecoder().decode(Entries.self, from: data)
                    guard let entriesItem = entries.entries else { return print("EntriesItem no items") }
                    
                    let set: [Entry] = entriesItem
                    
                    set.forEach {
                        guard
                            let strongSelf = self,
                            let description = $0.description,
                            let category = $0.category
                        else { return }
                        
                        let user = User(context: strongSelf.persistence.context)
                        user.name = description
                        user.category = category
                        print("user : \(String(describing: user.name))")
                        
                    }
                    DispatchQueue.main.async {
                        self!.persistence.save {
                            self?.persistence.fetch(User.self, completion: { (objects) in
                                completion(objects)
                            })
                        }
                        print("Save context")
                    }
        
                } catch {
                    print("error: \(error)")
                }
            case .failure(let error): print(error)
                
            }
            
        }
        
    }
}
