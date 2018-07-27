//
//  ViewController.m
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/10.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "ViewController.h"
#import "DPPageView.h"
#import "DPPageControl.h"
#import "DPController.h"
@interface ViewController (){
    DPPageView *page;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)normalBtn:(id)sender {
    DPController *vc = [[DPController alloc] init];
    vc.type = 0;
    self.title = @"123";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)cardBtn:(id)sender {
    DPController *vc = [[DPController alloc] init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
