#import "MapItemTableViewController.h"
#import "MapItemDetailViewController.h"

@implementation MapItemTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"map items";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.places = @[
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
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"myCell"];
    }
    
    cell.textLabel.text = self.places[indexPath.row][@"name"];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

                       - (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    MapItemDetailViewController *midvc = [[MapItemDetailViewController alloc] init];
    midvc.place = self.places[indexPath.row];
    [self presentViewController:midvc
                       animated:YES
                     completion:nil];
}

@end
