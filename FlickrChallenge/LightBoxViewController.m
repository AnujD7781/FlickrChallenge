//
//  DetailViewController.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "LightBoxViewController.h"
#import "PhotoDetails.h"
#import "CustomLightBoxImageView.h"

@interface LightBoxViewController () {
    int countActivity;
}

// Properties and IBOutlet

@property (nonatomic, strong) LightBoxDataCenter *lightBoxDataCenter;
@property (nonatomic, strong) PhotoDetails *imgDetailDataModel;
@property (weak, nonatomic) IBOutlet CustomLightBoxImageView *lightBoxImgView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openFlickrBtnAction;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;



- (IBAction)openFlickrAppForImageBtnAction:(id)sender;
- (IBAction)downloadImgBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblDescOwner;

@end

@implementation LightBoxViewController
@synthesize photo = _photo;

#pragma mark -  View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgDetailDataModel = [[PhotoDetails alloc]init];
    self.lightBoxDataCenter = [[LightBoxDataCenter alloc]init];
    self.lightBoxDataCenter.delegate = self;
    
    countActivity = 0;
}

-(void)viewDidAppear:(BOOL)animated {
        // if photo present get Original Photo and PhotoDetails
    if (_photo) {
        __block UIImage *image;
        [self setActivityIndicatorForView:YES];
        [self.lightBoxDataCenter getImageDetailsDataForPhoto:_photo];
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            image = _photo.imgLightBoxImage;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setActivityIndicatorForView:NO];
                    // then set them via the main queue if the cell is still visible.
                self.lightBoxImgView.image = image;
                image = nil;
            });
        }];
        [self.thumbnailQueue addOperation:operation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - BaseViewController Life cycle methods


-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

    // Did get data for PhotoDetails
-(void)didReceiveDataForImageDetailsView:(PhotoDetails*)imageDetailModel {
    self.imgDetailDataModel = imageDetailModel;
    [self updateDataForView];
}

    // did get error message for getting imgDetailDataModel
-(void)didGetError:(NSError*)error {
    [self showMessage:@"Oops. Something went wrong!! Please try again!!" withTitle:@"Error"];
}


#pragma mark - Light Box View helper
    // Update Description, owner and title for PhotoDetails.
-(void)updateDataForView {
    self.lblDescOwner.text = [NSString stringWithFormat:@"%@ by %@", self.imgDetailDataModel.strDescription, self.imgDetailDataModel.strOwner];
    self.lblTitle.text = [NSString stringWithFormat:@"%@", self.imgDetailDataModel.strTitle];
}


#pragma mark - IBAction Methods

    // Open flickr app with URLScheme for opened Image
- (IBAction)openFlickrAppForImageBtnAction:(id)sender {
    if (self.imgDetailDataModel) {
        if ([[UIApplication sharedApplication]canOpenURL: self.imgDetailDataModel.urlFlickr]) {
            [[UIApplication sharedApplication]openURL:self.imgDetailDataModel.urlFlickr];
        }
    } else {
        [self showMessage:@"Oops. Something went wrong!! Please try again!!" withTitle:@"Error"];
    }
}

    // Download UIImage Action
- (IBAction)downloadImgBtnAction:(id)sender {
    [self setActivityIndicatorForView:YES];
    if (_photo.imgLightBoxImage != NULL) {
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImageWriteToSavedPhotosAlbum(_photo.imgLightBoxImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
        
    }
}


#pragma mark - Callback for camera save data
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setActivityIndicatorForView:NO];
        
        if (error) { // Unable to save the image
            [self showMessage:@"Unable to save image to Photo Album." withTitle:@"Error"];
        }else { // All is well
            [self showMessage:@"Image saved!!" withTitle:@"Success"];
        }
    });
    
}

@end
