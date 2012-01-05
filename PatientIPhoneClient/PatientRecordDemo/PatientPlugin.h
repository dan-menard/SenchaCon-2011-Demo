//
//  PatientPlugin.h
//  PatientIPhoneClient
//
//  Created by Dan on 9/18/11.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PhoneGap/PGPlugin.h>

@interface PatientPlugin : PGPlugin {
    
}

- (void)getPatientList:(NSMutableArray*)args withDict:(NSMutableDictionary*)options;
- (void)getPatientDetails:(NSMutableArray*)args withDict:(NSMutableDictionary*)options;

@end
