//
//  ImageDetailDataModel.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "PhotoDetails.h"


@interface PhotoDetails ()
@property (nonatomic,strong) NSDictionary *imgDetailDict;

@end
@implementation PhotoDetails

#pragma mark - Init method
-(void)initWithDictionary:(NSDictionary*)dictPhotoDetail {
    self.imgDetailDict = [dictPhotoDetail objectForKey:@"photo"];
}

#pragma mark - Properties
-(NSURL*)urlFlickr {

    if ([[[[self.imgDetailDict objectForKey:@"urls"] objectForKey:@"url"] objectAtIndex:0] objectForKey:@"_content"]) {
        return [NSURL URLWithString:[[[[self.imgDetailDict objectForKey:@"urls"] objectForKey:@"url"] objectAtIndex:0] objectForKey:@"_content"]];
    }
    return nil;
}

-(NSString*)strOwner {
    if ([[self.imgDetailDict objectForKey:@"owner"] objectForKey:@"username"]) {
        return [NSString stringWithFormat:@"%@",[[self.imgDetailDict objectForKey:@"owner"] objectForKey:@"username"]];
    }
    return nil;
}

-(NSString*)strDescription {
    if ([[self.imgDetailDict objectForKey:@"description"] objectForKey:@"_content"]) {
        return [NSString stringWithFormat:@"%@",[[self.imgDetailDict objectForKey:@"description"] objectForKey:@"_content"]];
    }
    return nil;
}

-(NSString*)strTitle {
    if ([[self.imgDetailDict objectForKey:@"title"] objectForKey:@"_content"]) {
        return [NSString stringWithFormat:@"%@",[[self.imgDetailDict objectForKey:@"title"] objectForKey:@"_content"]];
    }
    return nil;
}
@end
