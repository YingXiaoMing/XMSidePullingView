//
//  Channel.h
//  仿QQ好友列表
//
//  Created by Kenfor-YF on 16/5/13.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
@property(nonatomic,strong)NSString *channel_num;
@property(nonatomic,strong)NSString *channel_name;
@property(nonatomic,strong)NSString *device_num;
+(instancetype)cellModeWithDict:(NSDictionary *)dict;

@end
