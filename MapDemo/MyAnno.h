#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnno : NSObject <MKAnnotation>

@property CLLocationCoordinate2D coordinate;
@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *subtitle;

@end