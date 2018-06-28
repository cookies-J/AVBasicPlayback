//
//  ViewController.m
//  AVBasicPlayback
//
//  Created by CMJele on 2018/6/27.
//  Copyright © 2018年 Jele. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AVAssetViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
@property (nonatomic, strong) NSArray <NSString *> *datasource;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"hi";
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)playerVideoButton:(id)sender {
//  NSURL *videoUrl = [NSURL URLWithString:@"https://guoxue-video.oss-cn-hangzhou.aliyuncs.com/1.m3u8"];
  NSURL *videoUrl = [[NSBundle mainBundle] URLForResource:@"Knockin' On Heaven's Door"
                                            withExtension:@"mp4"];
  NSURL *audioURL = [[NSBundle mainBundle] URLForResource:@"Knockin' On Heaven's Door"
                                          withExtension:@"mp3"];
  
  AVPlayer *player = [AVPlayer playerWithURL:videoUrl];
  AVPlayerViewController *avPlayerViewController = [[AVPlayerViewController alloc] init];
  avPlayerViewController.player = player;

  [self presentViewController:avPlayerViewController
                     animated:YES
                   completion:^{
                     NSLog(@"播放完成");
                   }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"tableViewCell"];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%ld - %@",indexPath.row + 1,self.datasource[indexPath.row]];
  return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.datasource.count;
}

- (NSArray<NSString *> *)datasource {
  return @[
           @"创建 Asset",
           ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
//  UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:[[AVAssetViewController alloc ] init]];
//  [self presentViewController:navigationViewController
//                     animated:YES
//                   completion:^{
//                     NSLog(@"success");
//                   }];
  [self.navigationController pushViewController:[[AVAssetViewController alloc] init] animated:YES];
}

@end
