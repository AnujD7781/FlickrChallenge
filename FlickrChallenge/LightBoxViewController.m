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
- (IBAction)backViewController:(id)sender;

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
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -

-(void)didReceiveDataForImageDetailsView:(PhotoDetails*)imageDetailModel {
    self.imgDetailDataModel = imageDetailModel;
    [self updateDataForView];
}

-(void)didGetError:(NSError*)error {
    [self showMessage:@"Oops. Something went wrong!! Please try again!!" withTitle:@"Error"];
}


#pragma mark - Light Box View helper
-(void)updateDataForView {
    self.lblDescOwner.text = [NSString stringWithFormat:@"%@ by %@", self.imgDetailDataModel.strDescription, self.imgDetailDataModel.strOwner];
    self.lblTitle.text = [NSString stringWithFormat:@"%@", self.imgDetailDataModel.strTitle];
}


#pragma mark - IBAction Methods
- (IBAction)backViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openFlickrAppForImageBtnAction:(id)sender {
    if (self.imgDetailDataModel) {
        if ([[UIApplication sharedApplication]canOpenURL: self.imgDetailDataModel.urlFlickr]) {
            [[UIApplication sharedApplication]openURL:self.imgDetailDataModel.urlFlickr];
        }
    } else {
        [self showMessage:@"Oops. Something went wrong!! Please try again!!" withTitle:@"Error"];
    }
}

- (IBAction)downloadImgBtnAction:(id)sender {
    if (_photo.imgLightBoxImage != NULL) {
        UIImageWriteToSavedPhotosAlbum(_photo.imgLightBoxImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}


#pragma mark - Callback for camera save data
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    // Unable to save the image
    if (error) {
        [self showMessage:@"Unable to save image to Photo Album." withTitle:@"Error"];
    }else {// All is well
        [self showMessage:@"Image saved!!" withTitle:@"Success"];
    }
}

@end
