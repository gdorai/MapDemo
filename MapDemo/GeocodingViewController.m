#import "GeocodingViewController.h"
#import "MyAnno.h"

@implementation GeocodingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Geocode Demo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc]
                    initWithFrame:CGRectMake(0,
                                           120,
                                             self.view.bounds.size.width,
                                             self.view.bounds.size.height-120)];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                    UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D startCenter =
    CLLocationCoordinate2DMake(28.540744,-81.378653);
    
    MKCoordinateSpan startSpan =
    MKCoordinateSpanMake(.02, .02);
    
    MKCoordinateRegion startRegion =
    MKCoordinateRegionMake(startCenter, startSpan);
    
    [self.mapView setRegion:startRegion animated:YES];
}

        - (void)mapView:(MKMapView *)mapView
regionDidChangeAnimated:(BOOL)animated
{
    MKCoordinateRegion region = mapView.region;
    
    self.coordinateOriginLabel.text = [NSString stringWithFormat:@"lat: %f, lng: %f",region.center.latitude, region.center.longitude];
    
    MKMapPoint point = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude));
            
    self.mapPointOriginLabel.text = [NSString stringWithFormat:@"x: %f, y: %f",point.x, point.y];
    
    self.grec = [[UILongPressGestureRecognizer alloc]
                                   initWithTarget:self
                                           action:@selector(handleGesture:)];
    self.grec.minimumPressDuration = 1.0;
    self.grec.delegate = self;
    [self.mapView addGestureRecognizer:self.grec];
    
    UIButton *randomPointButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    randomPointButton.frame = CGRectMake(20.0f, 20.0f, 280.0f, 50.0f);
    [randomPointButton setTitle:@"Generate Random US Point"
                       forState:UIControlStateNormal];
    [randomPointButton addTarget:self
                          action:@selector(generateRandomPoint:)
                forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomPointButton];
}

- (void)generateRandomPoint:(id)sender
{
    double randomLat = ((double)rand() / RAND_MAX) * (49 - 29) + 29;
    double randomLng = 0 - (((double)rand() / RAND_MAX) * (120 - 80) + 80);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *loc = [[CLLocation alloc]
                       initWithLatitude:randomLat
                       longitude:randomLng];
    
    [geocoder reverseGeocodeLocation:loc
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       MyAnno *randomAnno = [[MyAnno alloc] init];
                       randomAnno.coordinate = loc.coordinate;
                       randomAnno.title = placemark.name;
                       randomAnno.subtitle = placemark.administrativeArea;
                       
                       [self.mapView addAnnotation:randomAnno];
                       [self.mapView setCenterCoordinate:randomAnno.coordinate
                                                animated:YES];
                       [self.mapView selectAnnotation:randomAnno animated:YES];
                       MKCoordinateRegion region = MKCoordinateRegionMake(randomAnno.coordinate, MKCoordinateSpanMake(30, 30));
                       [self.mapView setRegion:region animated:YES];
                   }];
}

- (void)handleGesture:(UIGestureRecognizer *)grec
{
    if (self.grec.state == UIGestureRecognizerStateBegan){
        CGPoint point = [grec locationInView:self.mapView];
        
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView
                                                     convertPoint:point
                                             toCoordinateFromView:self.mapView];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        CLLocation *loc = [[CLLocation alloc]
                           initWithLatitude:touchMapCoordinate.latitude
                                  longitude:touchMapCoordinate.longitude];
        
        [geocoder reverseGeocodeLocation:loc
                       completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           
            MyAnno *userAnno = [[MyAnno alloc] init];
            userAnno.coordinate = touchMapCoordinate;
            userAnno.title = placemark.name;
            userAnno.subtitle = placemark.locality;
                           
            [self.mapView addAnnotation:userAnno];
            [self.mapView setCenterCoordinate:userAnno.coordinate
                                     animated:YES];
        }];
    }
}

@end
