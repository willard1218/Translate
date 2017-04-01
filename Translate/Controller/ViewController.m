//
//  ViewController.m
//  Translate
//
//  Created by willard on 2017/3/18.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = NULL;
    
    NSString *string = @"<span class='talk-transcript__fragment' data-time='953000' id='t-953000'>請幫助我把綠色變成吸引人的黑色，請幫我讓環保議題變得更引人注目，</span><span class='talk-transcript__fragment' data-time='958000' id='t-958000'>讓它成為你們茶餘飯後的話題。</span><span class='talk-transcript__fragment' data-time='962000' id='t-962000'>請幫我爭取環境和經濟正義，</span><span class='talk-transcript__fragment' data-time='965000' id='t-965000'>支持具有三層利益的投資案，</span><span class='talk-transcript__fragment' data-time='968000' id='t-968000'>幫助我把每個人都帶來這裡瞭解環保的好處，</span>";
//
 
    
//    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string
//                                                        options:0
//                                                          range:NSMakeRange(0, [string length])];
//    
//    NSLog(@"%lu",(unsigned long)numberOfMatches);
//    
//    NSString *strModifiedText = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
//    NSLog(strModifiedText);
//    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *URL = [NSURL URLWithString:@"https://www.ted.com/talks/majora_carter_s_tale_of_urban_renewal/transcript?language=zh-tw"];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:URL completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error) {
          NSString *contentType = nil;
          if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
              NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
              contentType = headers[@"Content-Type"];
          }
          
          NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<span class='talk-transcript__para__text'>[^<]*"
                                                                                 options:NSRegularExpressionCaseInsensitive
                                                                                   error:&error];
          
          NSArray<NSTextCheckingResult *> *result = [regex matchesInString:body options:NSMatchingReportProgress range:NSMakeRange(0, body.length)];
          for (NSTextCheckingResult* b in result)
          {
              NSRange matchRange = b.range;
//              matchRange.location += 75;
//              matchRange.length -= 74;
//              matchRange.length -= 8;
              NSString *matchString = [body substringWithRange:matchRange];
              NSLog(@"%@", matchString);
          }
          
          NSLog(@"");
      }] resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
