# FlickrChallenge
Models,
Photo
	properties for Photo information method “flickr.photos.search”. 
	Init with PhotoDictionary

PhotoDetails
	properties for Photo information method “flickr.photos.getInfo” with PhotoId 
	init with PhotoDetails.

PhotoFactory
	Factory to return photo for Thumbnail (_t) or LightBox (_o/_b/_c) (enum UIImageType)


HTTP Client
NetworkHTTPClient
	Handle API call and return data or error.

DataModeler
	Parse and convert data to Photo or PhotoDetails Model

Data Centers
CollectionViewDataCenter 
	CollectionViewDataCenterDelegate to get notified for data received for master View 		Controller or error received.
	getDataForCollectionViewForTags: Tagsinformation (“shark”)
	getDataForNextPageCollectionView
	refreshDataForCollectionView
	CountForCollectionViewCell (no of rows in numberOfItemsInSection)
	getPhotoAtIndexPath (get photo model for IndexPath)

LightBoxDataCenter
	LightBoxDataCenterDelegate get image details or error
	getImageDetailsDataForPhoto (parameter Photo Model for selected photo)

Views

Base & Custom Views and ViewControllers.
BaseViewController : UIViewController
	Methods for,
	Swipe Left & Right,
	Show Alert Messages,
	Show Network Activity Indicator
	NSOperationQueue

BaseCollectionView : UICollectionView
	with refreshView functionality
	BaseCollectionViewDelegate to handle pull down refresh functionality.

CustomRefreshView 
	CustomRefreshView (Pull down refresh with image Views and label) for CollectionView.

CustomLightBoxImageView : UIImageView
	Custom image view to handle gestures.
	method to reset imageView to original.

CollectionViewCell
	cell with properties for imageView thumbnail and activity indicator.

LandingPageViewController : BaseViewController
	landing page
	Swipe right to Open FeedMasterViewController

FeedMasterViewController : BaseViewController  
implements UICollectionViewDataSource, UICollectionViewDelegate, CollectionViewDataCenterDelegate, BaseCollectionViewDelegate
	SharkFeed with infinite scrolling 
	refreshFeed
	OnSelection pass Photo model at index to LightBoxViewController

LightBoxViewController : BaseViewController implements LightBoxDataCenterDelegate	
	property to set selected Photo model
	download big resolution image
	Get PhotoDetails for urlScheme, Title , description and owner.
	Download button and Open in Flickr App button.
	Pop self from navigationController on swipeRight
	



