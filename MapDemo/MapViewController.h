#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView
                           animated:(BOOL)animated;

@end