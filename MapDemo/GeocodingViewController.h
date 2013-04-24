#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GeocodingViewController : UIViewController <MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UILabel *mapPointOriginLabel;
@property (strong, nonatomic) UILabel *coordinateOriginLabel;
@property (strong, nonatomic) UILongPressGestureRecognizer *grec;

- (void)handleGesture:(id)grec;
- (void)generateRandomPoint:(id)sender;

@end
