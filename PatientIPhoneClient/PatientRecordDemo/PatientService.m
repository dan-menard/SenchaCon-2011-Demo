//
//  PatientService.m
//  PatientIPhoneClient
//  
//  A basic service for retreiving a list of patients, or details about a
//  specific patient.
//  
//  Uses CoreData to locally cache results, and returns these cached results
//  when an identical call is made.
//  
//  Created by Dan on 9/18/11.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import "PatientService.h"
#import "PatientListItem.h"
#import "PatientDetails.h"

#import "ASIHTTPRequest.h"
#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"

@implementation PatientService

- (NSString*)getPatientList {
    NSError* error = nil;
    NSManagedObjectContext* context = (NSManagedObjectContext*)[[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription* listItemEntity = [NSEntityDescription entityForName:@"PatientListItem" inManagedObjectContext:context];
    
    // Check the cache for the patient list.
    NSFetchRequest* fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:listItemEntity];
    NSArray* fetchResponse = [context executeFetchRequest:fetchRequest error:&error];
    
    // If we don't have the patient list in the cache, retrieve and cache it.
    if ([fetchResponse count] == 0) {
        NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8127/getPatientList"];
        ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
        
        [req startSynchronous];
        
        if ([req error]) {
            NSLog(@"%@", [[req error] description]);
            return nil;
        }
        else {
            // Deserialize the result into a list.
            NSData* patientListData = [(NSString*)[req responseString] dataUsingEncoding:NSUTF8StringEncoding];
            CJSONDeserializer* jsonDeserializer = [CJSONDeserializer new];
            NSDictionary* patientListResults = [jsonDeserializer deserializeAsDictionary:patientListData error:&error];
            [jsonDeserializer release];
            NSArray* patientList = [patientListResults objectForKey:@"patientList"];
            
            // Store the patient list items to the cache.
            for (int i=0; i<[patientList count]; i++ ) {
                NSDictionary* listItem = [patientList objectAtIndex:i];
                PatientListItem* listItemMO = (PatientListItem*)[[NSManagedObject alloc] initWithEntity:listItemEntity insertIntoManagedObjectContext:context];
                
                [listItemMO setPid:[listItem objectForKey:@"pid"]];
                [listItemMO setFirstName:[listItem objectForKey:@"firstName"]];
                [listItemMO setLastName:[listItem objectForKey:@"lastName"]];
            }
        }
    }
    
    // Pull the result from the cache.
    if ([fetchResponse count] == 0) {
        fetchRequest = [NSFetchRequest new];
        [fetchRequest setEntity:listItemEntity];
        fetchResponse = [context executeFetchRequest:fetchRequest error:&error];
    }
    
    // Serialize the result to JSON and return it.
    CJSONSerializer* jsonSerializer = [CJSONSerializer new];
    NSData* jsonData = [jsonSerializer serializeArray:fetchResponse error:&error];
    [jsonSerializer release];
    
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    return [jsonString autorelease];
}

- (NSString*)getPatientDetails:(int)patientId {
    NSError* error = nil;
    NSManagedObjectContext* context = (NSManagedObjectContext*)[[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription* patientDetailsEntity = [NSEntityDescription entityForName:@"PatientDetails" inManagedObjectContext:context];
    
    // Check the cache for the patient's details.
    NSFetchRequest* fetchRequest = [NSFetchRequest new];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"pid == %d", patientId];
    
    [fetchRequest setEntity:patientDetailsEntity];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchResponse = [context executeFetchRequest:fetchRequest error:&error];
    
    // If we don't have the desired patient's details in the cache, retrieve and cache them.
    if ([fetchResponse count] == 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8127/getPatientDetails?pid=%u", patientId]];
        ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
        
        [req startSynchronous];
        
        if ([req error]) {
            NSLog(@"%@", [[req error] description]);
            return nil;
        }
        else {
            // Deserialize the result into a dictionary.
            NSData* patientData = [(NSString*)[req responseString] dataUsingEncoding:NSUTF8StringEncoding];
            CJSONDeserializer* jsonDeserializer = [CJSONDeserializer new];
            NSDictionary* patientDetails = [jsonDeserializer deserializeAsDictionary:patientData error:&error];
            [jsonDeserializer release];
            
            // Store the patient details to the cache.
            PatientDetails* patientDetailsMO = (PatientDetails*)[[NSManagedObject alloc] initWithEntity:patientDetailsEntity insertIntoManagedObjectContext:context];
            
            [patientDetailsMO setPid:[patientDetails objectForKey:@"pid"]];
            [patientDetailsMO setFirstName:[patientDetails objectForKey:@"firstName"]];
            [patientDetailsMO setLastName:[patientDetails objectForKey:@"lastName"]];
            [patientDetailsMO setNote:[patientDetails objectForKey:@"note"]];
            [patientDetailsMO setPhysician:[patientDetails objectForKey:@"physician"]];
            [patientDetailsMO setDiagnosis:[patientDetails objectForKey:@"diagnosis"]];
        }
    }
    
    // Pull the result from the cache, if we haven't already.
    if ([fetchResponse count] == 0) {
        fetchRequest = [NSFetchRequest new];
        predicate = [NSPredicate predicateWithFormat:@"pid == %d", patientId];
        
        [fetchRequest setEntity:patientDetailsEntity];
        [fetchRequest setPredicate:predicate];
        
        fetchResponse = [context executeFetchRequest:fetchRequest error:&error];
    }
    
    // Serialize the result to JSON and return it.
    CJSONSerializer* jsonSerializer = [CJSONSerializer new];
    NSData* jsonData = [jsonSerializer serializeObject:[fetchResponse objectAtIndex:0] error:&error];
    [jsonSerializer release];
    
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    return [jsonString autorelease];
}

@end
