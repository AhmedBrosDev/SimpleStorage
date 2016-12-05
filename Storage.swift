//
//  Storage.swift
//  Grade Calculator
//
//  Created by M. Ahmed on 9/10/15.
//  Copyright (c) 2015 Syheed Ahmed. All rights reserved.

//Allows for simple core data save and load
//Save CoreData
//Storage().saveCoreData("Save This", forKey: "newKey")
//Reload CoreData
//Storage().loadCoreData(forKey: "newKey"))
//
import UIKit
import CoreData
class Storage {
    func loadCoreData(forKey key: String) -> String{
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        //Load + Update
        let request = NSFetchRequest(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        var results: NSArray = try! context.executeFetchRequest(request)
        //Remove Old results
        while results.count > 1 {
            context.deleteObject(results.firstObject as! NSManagedObject)
            do {
                try context.save()
            } catch _ {
            }
            results = try! context.executeFetchRequest(request)
        }
        if results.count > 0 {
            return String(stringInterpolationSegment: (results[0] as! NSManagedObject).valueForKey(key))
        }
        else{
            return String()
        }
    }
    
    func saveCoreData(str: String, forKey key: String){
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext!

        //Save CoreData
        let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: context) 
        newCourse.setValue(String(str as NSString) , forKey: key)
        do {
            try context.save()
        } catch let error {
            print("Could not cache the response \(error)")
        }
        
        
    }
}
