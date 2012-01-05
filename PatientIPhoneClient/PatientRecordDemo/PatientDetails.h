//
//  PatientDetails.h
//  PatientIPhoneClient
//
//  Created by Dan on 11-10-22.
//  Copyright (c) 2011 Macadamian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PatientDetails : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * diagnosis;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * pid;
@property (nonatomic, retain) NSString * physician;

@end
