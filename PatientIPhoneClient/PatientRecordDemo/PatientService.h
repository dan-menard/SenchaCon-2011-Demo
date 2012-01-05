//
//  PatientService.h
//  PatientIPhoneClient
//
//  Created by Dan on 9/18/11.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PatientService : NSObject {
    
}

- (NSString*)getPatientList;
- (NSString*)getPatientDetails:(int)patientId;

@end
