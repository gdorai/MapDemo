#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTrackerViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UILabel *mapPointOriginLabel;
@property (strong, nonatomic) UILabel *coordinateOriginLabel;

@end