//
//  AppDelegate.h
//  PatientRecordDemo
//
//  Created by Dan on 9/7/11.
//  Copyright Macadamian 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapDelegate.h>
#else
	#import "PhoneGapDelegate.h"
#endif

@interface AppDelegate : PhoneGapDelegate <NSFetchedResultsControllerDelegate> {

	NSString* invokeString;
}

@property (copy)  NSString* invokeString;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

