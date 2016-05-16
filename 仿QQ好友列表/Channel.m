//
//  Channel.m
//  仿QQ好友列表
//
//  Created by Kenfor-YF on 16/5/13.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import "Channel.h"

@implementation Channel
+(instancetype)cellModeWithDict:(NSDictionary *)dict
{
    Channel *channel = [[Channel alloc]init];
    [channel setValuesForKeysWithDictionary:dict];
    return channel;
}
@end
