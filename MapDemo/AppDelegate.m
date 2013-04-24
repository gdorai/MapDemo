#import "AppDelegate.h"
#import "MapItemTableViewController.h"
#import "MapViewController.h"
#import "MapTrackerViewController.h"
#import "GeocodingViewController.h"

@implementation AppDelegate

          - (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MapItemTableViewController *mitvc = [[MapItemTableViewController alloc] init];
    MapViewController *mvc = [[MapViewController alloc] init];
    MapTrackerViewController *mtvc = [[MapTrackerViewController alloc] init];
    GeocodingViewController *gvc = [[GeocodingViewController alloc] init];
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[mitvc, mvc, mtvc, gvc];
    
    self.window.rootViewController = tbc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
