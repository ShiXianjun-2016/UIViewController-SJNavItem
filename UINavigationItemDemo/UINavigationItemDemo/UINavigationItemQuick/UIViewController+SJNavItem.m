//
//  UIViewController+SJNavItem.m
//  UINavigationItemDemo
//
//  Created by 石显军 on 2017/9/7.
//  Copyright © 2017年 石显军. All rights reserved.
//

#import "UIViewController+SJNavItem.h"
#import <objc/runtime.h>

@implementation UIViewController (SJNavItem)


- (UIButton *)sjAddNavRightItemWithSJNavItem:(SJNavItem)item addTarget:(nullable id)target action:(SEL _Nullable)action
{
    return  [self sjGetItemInfoWithSJNavItem:item itemInfoCallBack:^(BOOL isImage, UIImage *image, NSString *title) {
        
        if (isImage) {
            return [self sjAddNavRightItemWithImage:image addTarget:target action:action];
        }else{
            return [self sjAddNavRightItemWithTitle:title addTarget:target action:action];
        }
        
    }];
}

- (UIButton *)sjAddNavRightItemWithSJNavItem:(SJNavItem)item chickItemCallBack:(SJNavitemCallBack _Nullable)callback
{
    return [self sjGetItemInfoWithSJNavItem:item itemInfoCallBack:^(BOOL isImage, UIImage *image, NSString *title) {
        
        if (isImage) {
            return [self sjAddNavRightItemWithImage:image chickItemCallBack:callback];
        }else{
            return [self sjAddNavRightItemWithTitle:title chickItemCallBack:callback];
        }
        
    }];
}

- (UIButton *)sjGetItemInfoWithSJNavItem:(SJNavItem)navItem itemInfoCallBack:(UIButton * (^)(BOOL isImage, UIImage *image, NSString *title))itemInfo
{
    BOOL        isImage = NO;
    UIImage     *image  = nil;
    NSString    *title  = nil;
    
    switch (navItem) {
        case SJNavItem_Done:
        {
            title = @"完成";
        }
            break;
        case SJNavItem_Done_Icon:
        {
            isImage = YES;
            image = [UIImage imageNamed:@"navItem_Done"];
        }
            break;
        case SJNavItem_Edit:
        {
            title = @"编辑";
        }
            break;
        case SJNavItem_Save:
        {
            title = @"保存";
        }
            break;
        case SJNavItem_Edit_Icon:
        {
            isImage = YES;
            image = [UIImage imageNamed:@"navItem_Edit"];
        }
            break;
    }
    
    if (itemInfo) {
        return itemInfo(isImage, image, title);
    }else{
        return nil;
    }
}

- (UIButton *)sjAddNavRightItemWithImage:(UIImage *_Nullable)image addTarget:(nullable id)target action:(SEL _Nullable)action
{
    UIButton *sender = [self sjGetNavItemView];
    [sender setImage:image forState:UIControlStateNormal];
    [sender addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self sjSetNavigationItemWithView:sender];
    
    return sender;
}

- (UIButton *)sjAddNavRightItemWithTitle:(NSString *_Nullable)title addTarget:(nullable id)target action:(SEL _Nullable)action
{
    UIButton *sender = [self sjGetNavItemView];
    [sender setTitle:title forState:UIControlStateNormal];
    [sender addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self sjSetNavigationItemWithView:sender];
    
    return sender;
}



- (UIButton *)sjAddNavRightItemWithImage:(UIImage *_Nullable)image chickItemCallBack:(SJNavitemCallBack _Nullable)callback
{
    self.sjCallback = callback;
    UIButton *sender = [self sjGetNavItemView];
    [sender setImage:image forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(sjChickNavItem:) forControlEvents:UIControlEventTouchUpInside];
    [self sjSetNavigationItemWithView:sender];
    
    return sender;
}

- (UIButton *)sjAddNavRightItemWithTitle:(NSString *_Nullable)title chickItemCallBack:(SJNavitemCallBack _Nullable)callback
{
    self.sjCallback = callback;
    UIButton *sender = [self sjGetNavItemView];
    [sender setTitle:title forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(sjChickNavItem:) forControlEvents:UIControlEventTouchUpInside];
    [self sjSetNavigationItemWithView:sender];
    
    return sender;
}

#pragma mark - Private
- (UIButton *)sjGetNavItemView
{
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, 40, 40);
    sender.adjustsImageWhenHighlighted = NO;
    [sender setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
    return sender;
}

- (void)sjSetNavigationItemWithView:(UIView *)view
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}


#pragma mark - Action
- (void)sjChickNavItem:(UIButton *)sender
{
    if (self.sjCallback) {
        self.sjCallback(sender);
    }
}

static char sjCallbackKey = 's';
#pragma mark - Getter

- (SJNavitemCallBack)sjCallback
{
    return objc_getAssociatedObject(self, &sjCallbackKey);
}

#pragma mark - Setter
- (void)setSjCallback:(SJNavitemCallBack)sjCallback
{
    objc_setAssociatedObject(self, &sjCallbackKey, sjCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
