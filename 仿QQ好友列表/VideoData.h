//
//  VideoData.h
//  仿QQ好友列表
//
//  Created by Kenfor-YF on 16/5/13.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoData : NSObject
@property(nonatomic,copy)NSString *device_name;
@property(nonatomic,strong)NSArray *channel_info;
@property(nonatomic,assign,getter=isOpen)BOOL open;
@end
