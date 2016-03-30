//
//  DataModeler.h
//  CollectionViewTrial
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoDetails.h"
@interface DataModeler : NSObject
+ (void)parseDataForCollectionView:(NSData *) data
                         onSuccess:(void(^)(NSDictionary *dict))success
                         onFailure:(void (^)(NSError *error))failureBlock;
+ (void)parseDataForImageDetails:(NSData *) data
                       onSuccess:(void(^)(PhotoDetails *dict))success
                       onFailure:(void (^)(NSError *error))failureBlock ;
@end
