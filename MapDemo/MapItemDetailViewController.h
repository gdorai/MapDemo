#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapItemDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *place;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *latLabel;
@property (strong, nonatomic) UILabel *lngLabel;

- (void)openMaps:(id)sender;
- (void)back:(id)sender;

@end