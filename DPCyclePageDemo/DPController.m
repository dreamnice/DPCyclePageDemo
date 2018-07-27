//
//  DPControllerViewController.m
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/12.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "DPController.h"
#import "DPPageView.h"

@interface DPController (){
    DPPageView *view;
}

@property (weak, nonatomic) IBOutlet UITextField *timetext;

@end

@implementation DPController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image1 = [UIImage imageNamed:@"00.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"01.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"02.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"03.jpg"];
    UIImage *image5 = [UIImage imageNamed:@"04.jpg"];
    UIImage *image6 = [UIImage imageNamed:@"05.jpg"];
    NSArray *imageArray = @[image1,image2,image3,image4,image5,image6];
    if(_type == 0){
        view = [[DPPageView alloc] initWithFrame:CGRectMake(10, 74, [UIScreen mainScreen].bounds.size.width - 20, 300) imageArray:imageArray scrollType:DPScrollTypeNormal];
        
    }else{
        view = [[DPPageView alloc] initWithFrame:CGRectMake(10, 74, [UIScreen mainScreen].bounds.size.width - 20, 300) imageArray:imageArray scrollType:DPScrollTypeCard];
    }
    [view setPageAlignment:DPPageAlignmentRight];
    [self.view addSubview:view];
}

- (IBAction)star:(id)sender {
    if(!([_timetext.text isEqualToString:@""] || !_timetext.text)){
        NSTimeInterval time = [_timetext.text doubleValue];
        [view setTimeInterval:time];
    }
    [view star];
}

- (IBAction)stop:(id)sender {
    [view stop];
}


@end
