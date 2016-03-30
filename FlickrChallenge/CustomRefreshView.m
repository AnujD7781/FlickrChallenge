//
//  CustomRefreshView.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "CustomRefreshView.h"

@implementation CustomRefreshView

#pragma mark - Custom Refresh View Method
+(UIView*)viewForRefreshView {
    @autoreleasepool {
        CGRect rect = [[UIScreen mainScreen]bounds];
        
        UIImage *imgPullToRefresh1 = [UIImage imageNamed:@"PullToRefresh_1"];
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x , rect.origin.y, imgPullToRefresh1.size.width, imgPullToRefresh1.size.height)];
        
        UIImage *imgPullToRefresh2 = [UIImage imageNamed:@"PullToRefresh2"];
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x , imageView1.frame.size.height+2, imgPullToRefresh2.size.width, imgPullToRefresh2.size.height)];
        
        imageView1.image = imgPullToRefresh1;
        imageView2.image = imgPullToRefresh2;
        
        imgPullToRefresh1 = nil;
        imgPullToRefresh2 = nil;
        
        UIView *refreshView = [[UIView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, imageView1.frame.size.height)];
        UILabel *lblText = [[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x, imageView2.frame.origin.y+imageView2.frame.size.height+2, 121, 15)];
        lblText.font = [UIFont systemFontOfSize:12.0];
        imageView1.center = CGPointMake(refreshView.frame.size.width  / 2, refreshView.frame.size.height / 2);
        imageView2.center = CGPointMake(refreshView.frame.size.width  / 2, refreshView.frame.size.height / 2+imageView1.frame.size.height+8);
        lblText.text = [NSString stringWithFormat:@"Pull To Refresh"];
        
        lblText.center = CGPointMake(refreshView.frame.size.width  / 2+20,
                                     refreshView.frame.size.height / 2+imageView2.frame.size.height+20);
        
        
        
        [refreshView addSubview:imageView1];
        [refreshView addSubview:imageView2];
        [refreshView addSubview:lblText];
        imageView1 = nil;
        imageView2 = nil;
        lblText = nil;
        return refreshView;
    }
    
    
}

@end
