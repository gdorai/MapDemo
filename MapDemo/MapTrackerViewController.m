#import "MapTrackerViewController.h"
#import "MyAnno.h"

@implementation MapTrackerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Map Tracker";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height-120)];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D startCenter =
    CLLocationCoordinate2DMake(28.540744,-81.378653);
    
    MKCoordinateSpan startSpan =
    MKCoordinateSpanMake(150, 150);
    
    MKCoordinateRegion startRegion =
    MKCoordinateRegionMake(startCenter, startSpan);
    
    [self.mapView setRegion:startRegion animated:YES];
    
    self.mapPointOriginLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,20,280,40)];
    self.mapPointOriginLabel.text = [NSString stringWithFormat:@"x: , y: "];
    [self.view addSubview:self.mapPointOriginLabel];
    
    self.coordinateOriginLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,70,280,40)];
    self.coordinateOriginLabel.text = [NSString stringWithFormat:@"x: , y: "];
    [self.view addSubview:self.coordinateOriginLabel];
    
    CLLocationCoordinate2D zeroCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    MyAnno *zeroCoordAnno = [[MyAnno alloc] init];
    zeroCoordAnno.coordinate = zeroCoord;
    zeroCoordAnno.title = @"zero zero coordinate";
    [self.mapView addAnnotation:zeroCoordAnno];

    MKMapPoint point = MKMapPointForCoordinate(zeroCoord);
    NSLog(@"point: %f, %f",point.x, point.y);
    
    CLLocationCoordinate2D zeroPoint = MKCoordinateForMapPoint(MKMapPointMake(0,0));
    NSLog(@"coord: %f, %f",zeroPoint.latitude, zeroPoint.longitude);
    MyAnno *zeroPointAnno = [[MyAnno alloc] init];
    zeroPointAnno.coordinate = zeroPoint;
    zeroPointAnno.title = @"zero zero point";
    [self.mapView addAnnotation:zeroPointAnno];

}

        - (void)mapView:(MKMapView *)mapView
regionDidChangeAnimated:(BOOL)animated
{
    MKCoordinateRegion region = mapView.region;
    NSLog(@"lat: %f, lng: %f, latDel: %f, lngDel: %f",region.center.latitude, region.center.longitude, region.span.latitudeDelta, region.span.longitudeDelta);
 
    self.coordinateOriginLabel.text = [NSString stringWithFormat:@"lat: %f, lng: %f",region.center.latitude, region.center.longitude];
    
    MKMapPoint point = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude));
    self.mapPointOriginLabel.text = [NSString stringWithFormat:@"x: %f, y: %f",point.x, point.y];
}

      - (void)mapView:(MKMapView *)mapView
didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"annotation %@ added",[[[views objectAtIndex:0] annotation] title]);
}

@end
