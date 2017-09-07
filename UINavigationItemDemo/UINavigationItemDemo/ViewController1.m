//
//  ViewController1.m
//  UINavigationItemDemo
//
//  Created by 石显军 on 2017/9/7.
//  Copyright © 2017年 石显军. All rights reserved.
//

#import "ViewController1.h"
#import "UIViewController+SJNavItem.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakself = self;
    UIButton *sender = [self sjAddNavRightItemWithSJNavItem:SJNavItem_Done chickItemCallBack:^(UIButton * _Nullable sender) {
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
    }];
    
    NSLog(@"sender title : %@", sender.titleLabel.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"ViewController1 销毁");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
