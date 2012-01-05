//
//  NSManagedObject+JSON.h
//  PatientIPhoneClient
//
//  Created by Dan on 11-10-22.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <objc/runtime.h>

@interface NSManagedObject (NSManagedObject_JSON)

- (NSData*)JSONDataRepresentation;

@end
