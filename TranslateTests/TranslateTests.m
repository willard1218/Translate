//
//  TranslateTests.m
//  TranslateTests
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WLArticle+CoreDataClass.h"
#import "WLQuiz+CoreDataClass.h"
@interface TranslateTests : XCTestCase

@end

@implementation TranslateTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateArticleWithDict {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"2403" ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *articleDict =
    [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    WLArticle *article = [WLArticle createEntityWithDict:articleDict];
    XCTAssertTrue([article.title isEqualToString:@"test"]);
    XCTAssertTrue([article.url isEqualToString:@"http:xxx"]);
    
    NSArray *quizs = article.quizs.array;
    XCTAssertEqual(quizs.count, 34);
    
    
    WLQuiz *quiz1 = quizs[0];
    XCTAssertTrue([quiz1.answer isEqualToString:@"Roy Price這個人，各位可能都未曾聽過，即使他曾負責過你生命中平凡無奇的22分鐘，在2013年4月19日這一天。他也許也曾負責帶給各位非常歡樂的22分鐘，但你們其中也許很多人並沒有。而這一切全部要回到Roy在三年前的一個決定。"]);
    
    XCTAssertTrue([quiz1.question isEqualToString:@"Roy Price is a man that most of you have probably never heard about, even though he may have been responsible for 22 somewhat mediocre  minutes of your life on April 19, 2013. He may have also been responsible for 22 very entertaining minutes, but not very many of you. And all of that goes back to a decision that Roy had to make about three years ago."]);
    
    NSLog(@"");
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

@end
