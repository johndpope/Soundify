//
//  SFCoreDataStack.swift
//  Soundify
//
//  Created by MaahiHiten on 19/10/16.
//  Copyright © 2016 MaahiHiten. All rights reserved.
//

import UIKit
import CoreData

class SFCoreDataStack: NSObject {
    
    // MARK: - Core Data stack
    
    static let sharedInstance = SFCoreDataStack()
    
    func saveContext () {
        
        let managedObjectContext = self.managedObjectContext
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                abort()
            }
        }
    }
    
    // #pragma mark - Core Data stack
    
    // Returns the managed object context for the application.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    var managedObjectContext: NSManagedObjectContext {
        if !(_managedObjectContext != nil) {
            let coordinator = self.persistentStoreCoordinator
            //            if coordinator != nil {
            _managedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
            _managedObjectContext!.persistentStoreCoordinator = coordinator
            // }
        }
        return _managedObjectContext!
    }
    var _managedObjectContext: NSManagedObjectContext? = nil
    
    // Returns the managed object model for the application.
    // If the model doesn't already exist, it is created from the application's model.
    var managedObjectModel: NSManagedObjectModel {
        if !(_managedObjectModel != nil) {
            let modelURL = Bundle.main.url(forResource: "SFItem", withExtension: "momd")
            _managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        }
        return _managedObjectModel!
    }
    var _managedObjectModel: NSManagedObjectModel? = nil
    
    // Returns the persistent store coordinator for the application.
    // If the coordinator doesn't already exist, it is created and the application's store added to it.
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        if !(_persistentStoreCoordinator != nil) {
            let storeURL = self.applicationDocumentsDirectory.appendingPathComponent("SFItem.sqlite")
            
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            
            
            do {
                try _persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            } catch  {
                
                /*
                 Replace this implementation with code to handle the error appropriately.
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 Typical reasons for an error here include:
                 * The persistent store is not accessible;
                 * The schema for the persistent store is incompatible with current managed object model.
                 Check the error message to determine what the actual problem was.
                 If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
                 If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                 * Simply deleting the existing store:
                 NSFileManager.defaultManager().removeItemAtURL(storeURL, error: nil)
                 * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
                 [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true}
                 Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
                 */
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
                
            }
        }
        return _persistentStoreCoordinator!
    }
    
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil
    
    // #pragma mark - Application's Documents directory
    
    // Returns the URL to the application's Documents directory.
    var applicationDocumentsDirectory: NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }
    

}
