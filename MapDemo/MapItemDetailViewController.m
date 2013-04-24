#import "MapItemDetailViewController.h"

@implementation MapItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if(self) {
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 50.0f)];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold"
                                          size:34.0f];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.nameLabel];

    self.latLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 280.0f, 40.0f)];
    self.latLabel.textColor = [UIColor blackColor];
    self.latLabel.font = [UIFont fontWithName:@"Helvetica"
                                         size:20.0f];
    self.latLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:self.latLabel];

    self.lngLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 130.0f, 280.0f, 40.0f)];
    self.lngLabel.textColor = [UIColor blackColor];
    self.lngLabel.font = [UIFont fontWithName:@"Helvetica"
                                         size:20.0f];
    self.lngLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:self.lngLabel];

    UIButton *mapsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mapsButton.frame = CGRectMake(20.0f, 180.0f, 280.0f, 44.0f);
    [mapsButton setTitle:@"Open in Maps"
                forState:UIControlStateNormal];
    [mapsButton addTarget:self
                   action:@selector(openMaps:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapsButton];    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(20.0f, 240.0f, 280.0f, 44.0f);
    [backButton setTitle:@"BACK"
                forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(back:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.nameLabel.text = self.place[@"name"];
    self.latLabel.text  = [NSString stringWithFormat:@"  lat: %@",self.place[@"lat"]];
    self.lngLabel.text  = [NSString stringWithFormat:@"  lng: %@",self.place[@"lng"]];
}

- (void)openMaps:(id)sender
{
    double lat = [self.place[@"lat"] doubleValue];
    double lng = [self.place[@"lng"] doubleValue];

    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat,lng) addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    [mapItem setName:self.place[@"name"]];
    
    [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsMapTypeKey: @0}];
}

- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end