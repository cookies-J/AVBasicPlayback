//
//  AVAssetViewController.m
//  AVBasicPlayback
//
//  Created by CMJele on 2018/6/28.
//  Copyright © 2018年 Jele. All rights reserved.
//

#import "AVAssetViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVAssetViewController ()

@end

@implementation AVAssetViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self initAsset];
}

- (void)initAsset {
  //创建 asset
  //  AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:@"https://guoxue-video.oss-cn-hangzhou.aliyuncs.com/1.m3u8"]];
  //  NSURL *fileUrl = [NSURL alloc] init];
  
  AVAsset *asset = [AVAsset assetWithURL:[[NSBundle mainBundle] URLForResource:@"Knockin' On Heaven's Door"
                                                                 withExtension:@"mp4"]];
  NSString *playableKey = @"playable";
  
  //检索 元数据
  NSString *formatKey = @"availableMetadataFormats";
  
  //使用 asset
  [asset loadValuesAsynchronouslyForKeys:@[playableKey, formatKey]
                       completionHandler:^{
                         
                         AVKeyValueStatus status;
                         NSError *error;
                         
                         status = [asset statusOfValueForKey:playableKey
                                                       error:&error];
                         if (error == nil) {
                           //play 状态
                           switch (status) {
                             case AVKeyValueStatusUnknown:
                               NSLog(@"😎 未知");
                               break;
                             case AVKeyValueStatusLoading:
                               NSLog(@"😎 加载中");
                               
                               break;
                             case AVKeyValueStatusLoaded: {
                               NSLog(@"😎 加载成功");
                             }
                               break;
                             case AVKeyValueStatusFailed:
                               NSLog(@"😎 失败");
                               break;
                             case AVKeyValueStatusCancelled:
                               NSLog(@"😎 已取消");
                               break;
                           }
                         }
                         
                         status = [asset statusOfValueForKey:formatKey
                                                       error:&error];
                         //解析元数据
                         if (error == nil) {
                           switch (status) {
                               
                             case AVKeyValueStatusUnknown: {
                               NSLog(@"😎 未知");
                             }
                               break;
                             case AVKeyValueStatusLoading:
                             {
                             NSLog(@"😎 加载中");
                             }
                               break;
                             case AVKeyValueStatusLoaded:
                             {
                             NSLog(@"😎 加载成功");
                             [asset.availableMetadataFormats enumerateObjectsUsingBlock:^(AVMetadataFormat  _Nonnull metaFormat, NSUInteger idx, BOOL * _Nonnull stop) {
                               NSLog(@"%@",[asset metadataForFormat:metaFormat]);
                             }];
                             }
                               break;
                             case AVKeyValueStatusFailed:
                             {
                             NSLog(@"😎 失败");
                             }
                               break;
                             case AVKeyValueStatusCancelled:
                             {
                             NSLog(@"😎 已取消");
                             }
                               break;
                           }
                         }
                       }];
  
  NSArray <AVMetadataItem *> *metadataItem = asset.commonMetadata;
  AVMetadataIdentifier titleId = AVMetadataCommonIdentifierTitle;
  NSArray <AVMetadataItem *> *titleItem = [AVMetadataItem metadataItemsFromArray:metadataItem
                                                            filteredByIdentifier:titleId];
  AVMetadataItem * item = titleItem.firstObject;
  NSLog(@"%@",item);
  
}

- (void)setViews {
  
}

@end
