//
//  CoreDataManagar.swift
//  elephants
//
//  Created by c94292a on 20/04/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "elephants")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func getElephants() -> [DBElephant] {
        var data: [DBElephant] = []
        do {
            data = try self.persistentContainer.viewContext.fetch(DBElephant.fetchRequest())
        } catch {
            print("An error ocurred")
        }
        return data
    }
    
    func saveElephant(elephant: Elephant) {
        let context = self.persistentContainer.viewContext
        var newElephant = DBElephant(context: context)
        newElephant.name = elephant.name
        newElephant.eldescription = elephant.note
        self.saveContext()

    }
    
    func deleteElephant(elephant: Elephant){
        let dbElephant = DBElephant(context: CoreDataManager().persistentContainer.viewContext)
        dbElephant.name = elephant.name
        dbElephant.eldescription = elephant.note
        persistentContainer.viewContext.delete(dbElephant)
        saveContext()
    }
    

    func deleteDBElephant(elephant: DBElephant){
        guard let elephantIdentifier = elephant.name else { return }
        let fetchRequest = DBElephant.fetchRequest()
        let predicate = NSPredicate(format: "elephantIdentifier==%@", elephantIdentifier)
        fetchRequest.predicate = predicate
        fetchRequest.includesPropertyValues = false

        if let objects = try? persistentContainer.viewContext.fetch(fetchRequest){
            for object in objects {
                persistentContainer.viewContext.delete(object)
            }
            saveContext()
        }
    }
    
}
