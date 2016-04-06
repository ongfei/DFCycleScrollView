//
//  ViewController.m
//  DFCycleScrollView
//
//  Created by qqqq on 15/12/16.
//  Copyright © 2015年 董永飞. All rights reserved.
//

#import "ViewController.h"
#import "DFCycleScrollView.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 1; i < 6; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
//        [arr addObject:image];
//        
//    }
    
//    DFCycleScrollView *df = [[DFCycleScrollView alloc] initWithFrame:CGRectMake(0, 20, 375, 400) imagesGroup:arr];
//    [self.view addSubview:df];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"http://pkimg.image.alimmdn.com/upload/20151216/975a2fea6ae788914ef5267a5baaf9f4.jpeg",@"http://pkimg.image.alimmdn.com/upload/20151216/172f05fc65d1d8450aaac75005783d5d.jpeg",@"http://pkimg.image.alimmdn.com/upload/20151216/6dcd120f3f273b4995b304de5b244dd1.jpeg",@"http://pkimg.image.alimmdn.com/upload/20151216/af2df82e253cc9c0826cb637969ff7bd.jpeg",@"http://pkimg.image.alimmdn.com/upload/20151216/f88b792e40bbc0e1dffcec30f99b83cf.jpeg", nil];
    [self.view addSubview:[DFCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, 375, 400) imageURLStringsGroup:arr]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
