//
//  LeftHeadView.h
//  仿QQ好友列表
//
//  Created by Kenfor-YF on 16/5/13.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

#import "VideoData.h"
@protocol LeftHeadViewDelegate<NSObject>
-(void)LeftHeadViewClick:(Channel *)channel;
@end
@interface LeftHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong)Channel *channel;
@property(nonatomic,strong)VideoData *videoData;
@property(nonatomic,strong)NSMutableArray *tmpData;
@property(nonatomic,weak)id<LeftHeadViewDelegate> delegate;
+(instancetype)headViewWithTableView:(UITableView *)tableView;
@end
