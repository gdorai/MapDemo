/*
 * - (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView
 *                            animated:(BOOL)animated
 * method from: http://brianreiter.org/2012/03/02/size-an-mkmapview-to-fit-its-annotations-in-ios-without-futzing-with-coordinate-systems/
 */


#import "MapViewController.h"
#import "MyAnno.h"

#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Map View";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc] init];
    self.mapView.frame = CGRectMake(0,
                                    0,
                                    self.view.bounds.size.width,
                                    self.view.bounds.size.height);
    
    self.mapView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
    
    self.mapView.mapType = MKMapTypeStandard;
    
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D startCenter =
        CLLocationCoordinate2DMake(28.540744,-81.378653);
    
    MKCoordinateSpan startSpan =
        MKCoordinateSpanMake(.01, .01);
    
    MKCoordinateRegion startRegion =
        MKCoordinateRegionMake(startCenter, startSpan);
    
    [self.mapView setRegion:startRegion animated:YES];
    
    CLLocationCoordinate2D annoCoord =
        CLLocationCoordinate2DMake(28.544192, -81.373286);
    
    MyAnno *annotation = [[MyAnno alloc] init];
    annotation.coordinate = annoCoord;
    annotation.title = @"Lake Eola";
    annotation.subtitle = @"Cool swans";
    
    [self.mapView addAnnotation:annotation];
    
    NSArray *locations = @[
                    @{@"name": @"Lake Eola",
                      @"lat": @"28.544192",
                      @"lng":@"-81.373286"},
                    @{@"name": @"Lake Lawsona",
                      @"lat": @"28.540874",
                      @"lng": @"-81.364317"},
                    @{@"name": @"Lake Lucerne",
                      @"lat": @"28.534616",
                      @"lng": @"-81.378179"}
                    ];

    for(NSDictionary *loc in locations) {
        CLLocationCoordinate2D aCoord = CLLocationCoordinate2DMake([loc[@"lat"] doubleValue], [loc[@"lng"] doubleValue]);
        MyAnno *anno = [[MyAnno alloc] init];
        anno.coordinate = aCoord;
        anno.title = loc[@"name"];
        anno.subtitle = nil;
        [self.mapView addAnnotation:anno];
    }
    [self zoomMapViewToFitAnnotations:self.mapView
                             animated:YES];
}

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView
                           animated:(BOOL)animated
{
    NSArray *annotations = mapView.annotations;
    int count = [mapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
        }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) {
        region.span.latitudeDelta = MAX_DEGREES_ARC;
    }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ) {
        region.span.longitudeDelta = MAX_DEGREES_ARC;
    }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta < MINIMUM_ZOOM_ARC ) {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
    }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) {
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 ) {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [mapView setRegion:region
              animated:animated];
}

@end