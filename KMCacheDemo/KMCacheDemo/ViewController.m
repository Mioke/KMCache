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
    
    self.cache = [[KMCache alloc] initWithType:KMCacheTypeDefualt];
    
    for (int i = 0; i < 10000; i ++) {
        [self.cache setCacheObject:@(i) forKey:@(i)];
        
        usleep(1000 * 1000);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
