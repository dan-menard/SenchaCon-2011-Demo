//
//  NSManagedObject+JSON.m
//  PatientIPhoneClient
//  
//  A quick manual serialization to make our model objects JSON-compatible.
//  
//  Created by Dan on 11-10-22.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import "NSManagedObject+JSON.h"
#import "CJSONSerializer.h"

@implementation NSManagedObject (NSManagedObject_JSON)

- (NSData*)JSONDataRepresentation {
    NSDictionary *attributesByName = [[self entity] attributesByName];
    NSMutableDictionary *valuesDictionary = [[self dictionaryWithValuesForKeys:[attributesByName allKeys]] mutableCopy];
    
    CJSONSerializer *serializer = [CJSONSerializer new];
    
    NSError* error = nil;
    NSData* jsonData = [serializer serializeObject:valuesDictionary  error:&error];
    [serializer release];
    
    if (error) {
        NSLog(@"Could not serialize managed object (%@) to JSON : %@", NSStringFromClass([self class]), error);
    }
    
	return jsonData;
}

@end
