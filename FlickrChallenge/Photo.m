//
//  Photos.m
//  TrialUIHelperProject
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "Photo.h"
#import "PhotoFactory.h"

@interface Photo () {
    NSDictionary *dictBaseData;
}

@end
@implementation Photo
@synthesize photoId = _photoId;
@synthesize imgLightBoxImage = _imgLightBoxImage;
@synthesize imgThumbnailImage = _imgThumbnailImage;
@synthesize farm = _farm;
@synthesize owner = _owner;
@synthesize secret = _secret;
@synthesize title = _title;
@synthesize urlFullScreenImg = _urlFullScreenImg;
@synthesize urlFullScreenImg_B = _urlFullScreenImg_B;
@synthesize urlFullScreenImg_C = _urlFullScreenImg_C;
@synthesize urlImgThumbnailImg = _urlImgThumbnailImg;
@synthesize server = _server;


#pragma mark - Init method

-(void)initWithDictionary:(NSDictionary*)dictPhotos {
    dictBaseData = dictPhotos;
    
    _urlImgThumbnailImg = [NSURL URLWithString:[dictBaseData valueForKey:@"url_t"]];
    _urlFullScreenImg = [NSURL URLWithString:[dictBaseData valueForKey:@"url_o"]];
    _urlFullScreenImg_B = [NSURL URLWithString:[dictBaseData valueForKey:@"url_b"]];
    _urlFullScreenImg_C = [NSURL URLWithString:[dictBaseData valueForKey:@"url_c"]];
}

#pragma mark - Propoerties

-(NSString*)farm {
    if ([dictBaseData valueForKey:@"farm"]) {
        _farm = [dictBaseData valueForKey:@"farm"];
        return _farm;
    }
    return nil;
}

-(NSString*)photoId {
    if ([dictBaseData valueForKey:@"id"]) {
        _photoId = [dictBaseData valueForKey:@"id"];
        return _photoId;
    }
    return nil;
}

-(NSString*)owner {
    if ([dictBaseData valueForKey:@"owner"]) {
        _owner = [dictBaseData valueForKey:@"owner"];
        return _owner;
    }
    return nil;
}

-(NSString*)secret {
    if ([dictBaseData valueForKey:@"owner"]) {
        _secret = [dictBaseData valueForKey:@"owner"];
        return _secret;
    }
    return nil;
}

-(NSString*)server {
    if ([dictBaseData valueForKey:@"server"]) {
        _server = [dictBaseData valueForKey:@"server"];
        return _server;
    }
    return nil;
}
    
-(NSString*)title {
    if ([dictBaseData valueForKey:@"title"]) {
        _title = [dictBaseData valueForKey:@"title"];
        return _title;
    }
    return nil;
}

    // Do not save this image because of its size.
-(UIImage*)imgLightBoxImage {
    return [[PhotoFactory getSharedInstance] imageFactoryForPhotoData:self from:UIImageLightBox];
}

    // Save this image to see help make view more responsive and avoid reloading.
-(UIImage*)imgThumbnailImage {
    if (!_imgThumbnailImage) {
        _imgThumbnailImage = [[PhotoFactory getSharedInstance] imageFactoryForPhotoData:self from:UIImageThumbnail];
    }
    return _imgThumbnailImage;
}

@end
