//
//  ViewController.m
//  仿QQ好友列表
//
//  Created by Kenfor-YF on 16/5/13.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import "ViewController.h"
#import "Channel.h"
#import "LeftHeadView.h"
#import "VideoData.h"
#define XMHeight [UIScreen mainScreen].bounds.size.height
#define XMWidth  [UIScreen mainScreen].bounds.size.width
#define setBgColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface ViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,LeftHeadViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sideBtn;
@property(nonatomic,weak)UIView *leftView;
@property(nonatomic,assign,getter=isShow)BOOL show;
@property(nonatomic,weak)UIView *maskView;
@property(nonatomic,weak)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray *tmpArray;
@end

@implementation ViewController
-(NSMutableArray *)tmpArray
{
    if (!_tmpArray) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"channel.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSArray *dictArray = dict[@"data"];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            VideoData *data = [[VideoData alloc]init];
            data.device_name = dict[@"device_name"];
            data.channel_info = dict[@"channel_info"];
            [tmpArray addObject:data];
        }
        self.tmpArray = tmpArray;
    }
    return _tmpArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(-140, 20, 140, XMHeight - 20)];
    self.leftView = leftView;
    leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftView];
    [self setupTableView];
}
-(void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *mainTableView = [[UITableView alloc]initWithFrame:self.leftView.bounds style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.bounces = NO;
    mainTableView.backgroundColor = [UIColor whiteColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView = mainTableView;
    [self.leftView addSubview:self.mainTableView];
}

- (IBAction)btnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.leftView.frame = CGRectMake(0, 20, 140, XMHeight - 20);
    }];
    //添加蒙版
    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(140, 20, XMWidth - 140, XMHeight)];
    maskView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [maskView addGestureRecognizer:tap];
    [self.view addSubview:maskView];
    self.maskView = maskView;
    self.show = YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.leftView) {
        return NO;
    }
    return YES;
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    if (self.isShow) {
        [UIView animateWithDuration:0.5 animations:^{
            self.leftView.frame = CGRectMake(-140, 20, 140, XMHeight - 20);
        }];
        self.show = NO;
        [self.maskView removeFromSuperview];
    }
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tmpArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VideoData *videoData = self.tmpArray[section];
    if (videoData.isOpen) {
        return videoData.channel_info.count;
    }else{
        return 0.1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    VideoData *videoData = self.tmpArray[indexPath.section];
    Channel *model = [Channel cellModeWithDict:(NSDictionary *)videoData.channel_info[indexPath.row]];
    cell.textLabel.text = model.channel_name;
    cell.textLabel.textColor = setBgColor(205, 14, 21);
    cell.backgroundColor = setBgColor(232, 232, 232);
    cell.clipsToBounds = YES;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LeftHeadView *leftHeadView = [LeftHeadView headViewWithTableView:tableView];
    leftHeadView.delegate = self;
    VideoData *videoData = self.tmpArray[section];
    leftHeadView.videoData = videoData;
    leftHeadView.tmpData = self.tmpArray;
    return leftHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma mark -LeftHeadViewDelegate
-(void)LeftHeadViewClick:(Channel *)channel
{
    [self.mainTableView reloadData];
}













@end
