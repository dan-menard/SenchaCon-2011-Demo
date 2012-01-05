//
//  PatientListItem.h
//  PatientIPhoneClient
//
//  Created by Dan on 11-10-22.
//  Copyright (c) 2011 Macadamian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PatientListItem : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * pid;

@end
