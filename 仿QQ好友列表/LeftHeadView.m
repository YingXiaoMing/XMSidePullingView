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
@property(nonatomic,weak)UIView *line1;
@property(nonatomic,weak)UIView *line2;

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
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor clearColor];
        [self addSubview:line1];
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor clearColor];
        [self addSubview:line2];
        self.line1 = line1;
        self.line2 = line2;
    }
    return self;
}
-(void)btnClick:(UIButton *)sender
{
    for (int i=0; i<3; i++) {
        if (self.videoData == self.tmpData[i]){
            continue;
        }
        VideoData *model = self.tmpData[i];
        model.open = NO;
    }
    self.videoData.open = !self.videoData.isOpen;
    NSLog(@"%d",self.videoData.isOpen);
    
    if ([self.delegate respondsToSelector:@selector(LeftHeadViewClick:)]) {
        [self.delegate LeftHeadViewClick:self.channel];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.btn.frame = CGRectMake(0, 1, self.bounds.size.width, self.bounds.size.height - 2);
    self.line1.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
    self.line2.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
}
-(void)setVideoData:(VideoData *)videoData
{
    _videoData = videoData;
    [self.btn setTitle:videoData.device_name forState:UIControlStateNormal];
    if (videoData.isOpen) {
        self.btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
@end
