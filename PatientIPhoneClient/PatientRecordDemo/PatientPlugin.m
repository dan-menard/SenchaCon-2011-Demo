//
//  PatientPlugin.m
//  PatientIPhoneClient
//  
//  PhoneGap plugin to manage the connection to Javascript.
//  
//  Created by Dan on 9/18/11.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import "PatientPlugin.h"
#import "PatientService.h"


@implementation PatientPlugin

- (void)getPatientList:(NSMutableArray*)args withDict:(NSMutableDictionary*)options {
    NSString *successCallback = [options valueForKey:@"successCallback"];
    NSString *failureCallback = [options valueForKey:@"failureCallback"];
    
    PatientService* service = [[PatientService new] autorelease];
    NSString* result = [service getPatientList];
    
    if (result) {
        [self writeJavascript: [NSString stringWithFormat:@"%@([%@]);", successCallback, result]];
    }
    else {
        [self writeJavascript: [NSString stringWithFormat:@"%@('No results for getPatientList.');", failureCallback]];
    }
}

- (void)getPatientDetails:(NSMutableArray*)args withDict:(NSMutableDictionary*)options {
    NSString *successCallback = [options valueForKey:@"successCallback"];
    NSString *failureCallback = [options valueForKey:@"failureCallback"];
    long pid = [(NSString*)[options valueForKey:@"pid"] intValue];
    
    PatientService* service = [[PatientService new] autorelease];
    NSString* result = [service getPatientDetails:pid];
    
    if (result) {
        [self writeJavascript: [NSString stringWithFormat:@"%@([%@]);", successCallback, result]];
    }
    else {
        [self writeJavascript: [NSString stringWithFormat:@"%@('No results for getPatientList.');", failureCallback]];
    }
}

@end
