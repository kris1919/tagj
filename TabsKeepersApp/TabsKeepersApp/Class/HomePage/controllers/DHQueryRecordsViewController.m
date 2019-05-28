//
//  DHQueryRecordsViewController.m
//  DataAdapterExample_Example
//
//  Created by 32943 on 2018/2/9.
//  Copyright © 2018年 ly. All rights reserved.
//

#import "DHQueryRecordsViewController.h"
#import "DHHudPrecess.h"
#import "ZComBoxView.h"
#import "DHPlaybackManager.h"
#import "DHDataCenter.h"
#import "DHPlaybackViewController.h"

@interface DHQueryRecordsViewController ()<ZComBoxViewDelegate>
{
    RecordSource recordSourceType;
}
@property (nonatomic ,strong)NSArray *recordInfos;

@end

@implementation DHQueryRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化回放设置label内容
    NSDate* pDate = [NSDate date];
    NSDateFormatter* pDateFormatter = [[NSDateFormatter alloc] init];
    [pDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    self.beginTimeLabel.text = [pDateFormatter stringFromDate:pDate];
    [pDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    self.endTimeLabel.text = [pDateFormatter stringFromDate:pDate];
    self.recordResourceLabel.text = @"";
    
}

- (IBAction)onBtnQueryRecord:(id)sender
{
    [[DHHudPrecess sharedInstance]showWaiting:@""
                               WhileExecuting:@selector(threadQueryRecord)
                                     onTarget:self
                                   withObject:Nil
                                     animated:NO
                                       atView:self.view];
}
//录像查询
- (void)threadQueryRecord
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *queryDate =[dateFormatter dateFromString:self.beginTimeLabel.text];
    NSDate *laterDate =[dateFormatter dateFromString:self.endTimeLabel.text];
    if ([queryDate compare:laterDate] != NSOrderedAscending) {
        MSG(@"", @"开始时间要小于结束时间", @"");
        return;
    }

    if(_recordResourceLabel.text.length == 0){
        MSG(@"", @"请选择播放源", @"");
        return;
    }
    NSError *error = nil;
    self.recordInfos = [[DHPlaybackManager sharedInstance] queryRecord:[DHDataCenter sharedInstance].channelId begin:queryDate end:laterDate source:recordSourceType error:&error];
    
    if (error.code != 0)
    {
        MSG(@"", @"查询失败", @"");
    }
    if (self.recordInfos.count == 0)
    {
        MSG(@"", @"没有录像", @"");
    } else{
        [self playBack];
    }
}
- (void)playBack{
    dispatch_async(dispatch_get_main_queue(), ^{
        DHPlaybackViewController *playVC = [TKUtils viewControllerWithStory:@"Main" storyId:@"DHPlaybackViewController"];
        playVC.recordsArray = self.recordInfos;
        [self.navigationController pushViewController:playVC animated:YES];
    });
}

- (IBAction)onBtnSetBeginTime:(id)sender {
    ZComBoxView* comBox = [[ZComBoxView alloc] initFrameSetBeginTime:[[UIApplication sharedApplication] keyWindow].frame];
    comBox.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:comBox];
}

- (IBAction)onBtnSetEndTime:(id)sender {
    ZComBoxView* comBox = [[ZComBoxView alloc] initFrameSetEndTime:[[UIApplication sharedApplication] keyWindow].frame];
    comBox.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:comBox];
}

- (IBAction)onBtnSetRecordResource:(id)sender {
    ZComBoxView* comBox = [[ZComBoxView alloc] initFrameSetRecordResource:[[UIApplication sharedApplication] keyWindow].frame];
    comBox.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:comBox];
}

- (void) setBeginTime:(NSDate*)time{
    NSDateFormatter* pDateFormatter = [[NSDateFormatter alloc] init];
    [pDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    self.beginTimeLabel.text = [pDateFormatter stringFromDate:time];
}
- (void) setEndTime:(NSDate*)time{
    NSDateFormatter* pDateFormatter = [[NSDateFormatter alloc] init];
    [pDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    self.endTimeLabel.text = [pDateFormatter stringFromDate:time];
}

- (void) setRecordResourc:(int)type{
    NSArray* array = [[NSArray alloc] initWithObjects:@"所有录像",@"设备录像",@"平台录像", nil];
    recordSourceType = type;
    self.recordResourceLabel.text = array[type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"playback"]) {
        DHPlaybackViewController *playbackViewController = segue.destinationViewController;
        playbackViewController.recordsArray = self.recordInfos;
    }
}


@end
