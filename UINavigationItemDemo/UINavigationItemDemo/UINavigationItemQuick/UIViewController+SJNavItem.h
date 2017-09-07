//
//  UIViewController+SJNavItem.h
//  UINavigationItemDemo
//
//  Created by 石显军 on 2017/9/7.
//  Copyright © 2017年 石显军. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SJNavItem) {
    SJNavItem_Done,             // 完成
    SJNavItem_Done_Icon,        // 完成 图标
    SJNavItem_Save,             // 保存
    SJNavItem_Edit,             // 编辑
    SJNavItem_Edit_Icon,        // 编辑图标
};

typedef void (^ SJNavitemCallBack)(UIButton * _Nullable sender);


@interface UIViewController (SJNavItem)


/**
 rightBarButtonItem 添加一个按钮

 @param item  SJNavItem 按钮类型
 @param target 触发方法所属类
 @param action 触发方法
 @return 添加的 UIButton 实例
 */
- (UIButton *_Nullable)sjAddNavRightItemWithSJNavItem:(SJNavItem)item addTarget:(nullable id)target action:(SEL _Nullable)action;

- (UIButton *_Nullable)sjAddNavRightItemWithImage:(UIImage *_Nullable)image addTarget:(nullable id)target action:(SEL _Nullable)action;

- (UIButton *_Nullable)sjAddNavRightItemWithTitle:(NSString *_Nullable)title addTarget:(nullable id)target action:(SEL _Nullable)action;


/**
 回调
 */
@property (nonatomic, copy) SJNavitemCallBack _Nullable sjCallback;


/**
 rightBarButtonItem 添加一个按钮

 @param item SJNavItem 按钮类型
 @param callback 按钮点击回调
 @return 添加的 UIButton 实例
 */
- (UIButton *_Nullable)sjAddNavRightItemWithSJNavItem:(SJNavItem)item chickItemCallBack:(SJNavitemCallBack _Nullable)callback;

- (UIButton *_Nullable)sjAddNavRightItemWithImage:(UIImage *_Nullable)image chickItemCallBack:(SJNavitemCallBack _Nullable)callback;

- (UIButton *_Nullable)sjAddNavRightItemWithTitle:(NSString *_Nullable)title chickItemCallBack:(SJNavitemCallBack _Nullable)callback;

@end
