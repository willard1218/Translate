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
@property (strong, nonatomic) WLArticle *article;
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *articleDict =
    [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    _article = [WLArticle createEntityWithDict:articleDict];
    XCTAssertTrue([_article.title isEqualToString:@"Al Gore On Averting Climate Crisis"]);
    XCTAssertTrue([_article.url isEqualToString:@"http://www.ted.com/talks/al_gore_on_averting_climate_crisis"]);
    
    [_article setupQuizsWithDictionary:articleDict];
    NSArray *quizs = _article.quizs.array;
    XCTAssertEqual(quizs.count, 62);
    
    
    WLQuiz *quiz1 = quizs[0];
    XCTAssertEqualObjects(quiz1.answer, @"非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。");
    
    XCTAssertEqualObjects(quiz1.question, @"Thank you so much, Chris. And it's truly a great honorto have the opportunity to come to this stage twice;I'm extremely grateful. I have been blown away by this conference, and I want to thank all of youfor the many nice comments about what I had to say the other night.");
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
