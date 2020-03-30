//
//  MobADDemoTests.m
//  MobADDemoTests
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 Max. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MobAD/MobAD.h>

@interface MobADDemoTests : XCTestCase

@end

@implementation MobADDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - 获取版本号

- (void)testGetSDKVersion
{
    NSString *ver = [MobAD version];
    XCTAssertEqual(ver, @"2.0.0");
}



@end
