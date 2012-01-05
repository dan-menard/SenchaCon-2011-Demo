//
//  Test.m
//  Test
//  
//  A very small test suite to check that the webserver is returning data.
//  
//  Created by Dan on 9/18/11.
//  Copyright 2011 Macadamian. All rights reserved.
//

#import "Test.h"
#import "TestConstants.h"


@implementation Test

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetPatientList
{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8127/getPatientList"];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    
    [req startSynchronous];
    
    if ([req error]) {
        NSLog(@"Error retrieving patient list!");
    }
    else {
        NSLog(@"Patient List: \n%@", [req responseString]);
    }
}

- (void)testGetPatientDetails
{
    int pid = kPATIENT_ID_TONY;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8127/getPatientDetails?pid=%u", pid]];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    
    [req startSynchronous];
    
    if ([req error]) {
        NSLog(@"Error retrieving patient list!");
    }
    else {
        NSLog(@"Patient Details for %d: %@\n", pid, [req responseString]);
    }
}

@end
