//
//  LeftHeadView.m
//  仿QQ好友列表
//
//  Created by Kenfor-YF on 16/5/13.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import "LeftHeadView.h"
#define setBgColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface LeftHeadView()
@property(nonatomic,weak)UIButton *btn;

@end

@implementation LeftHeadView
+(instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LeftHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headView == nil) {
        headView = [[LeftHeadView alloc]initWithReuseIdentifier:ID];
    }
    return headView;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"triangle_right_114px_1189854_easyicon.net"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageView.contentMode = UIViewContentModeCenter;
        btn.imageView.layer.masksToBounds = NO;
        btn.backgroundColor = setBgColor(205, 205, 205);
        [btn setTitleColor:setBgColor(54, 54, 54) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.btn = btn;
    }
    return self;
}
-(void)btnClick:(UIButton *)sender
{
    for (int i=0; i<self.channel.device.count; i++) {
        if (self.channel.device[i] == self.headName) continue;
        
    }
    self.channel.open = !self.channel.isOpen;
    if ([self.delegate respondsToSelector:@selector(LeftHeadViewClick:)]) {
        [self.delegate LeftHeadViewClick:self.channel];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.btn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}
-(void)setHeadName:(NSString *)headName
{
    _headName = headName;
    [self.btn setTitle:headName forState:UIControlStateNormal];
}
-(void)setChannel:(Channel *)channel
{
    _channel = channel;
    NSLog(@"%d",_channel.isOpen);
    if (_channel.isOpen) {//要打开
        self.btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
@end
