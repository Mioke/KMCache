//
//  ViewController.m
//  KMCacheDemo
//
//  Created by Klein Mioke on 15/12/16.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import "ViewController.h"
#import "KMCache.h"

@interface ViewController ()

@property (nonatomic, strong) KMCache *cache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cache = [[KMCache alloc] initWithType:KMCacheTypeReleaseByTime];
    self.cache.maxCount = 50;
    
    self.cache.releaseTime = 20;
}
- (IBAction)click:(id)sender {
    
    static int i = 0;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (int j = i ; i < j + 10000; i ++) {
            [self.cache setCacheObject:[UIImage imageNamed:@"apple-touch-icon"] forKey:@(i)];
            NSLog(@"insert : %d: %d", i, i);
        }
    });
}
- (IBAction)size:(id)sender {
    NSLog(@"%lu", (unsigned long)[self.cache size]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
