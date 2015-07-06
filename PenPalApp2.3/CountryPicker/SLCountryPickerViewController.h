// country

#import <UIKit/UIKit.h>

//@interface SLCountryPickerViewController : UITableViewController

@interface SLCountryPickerViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    UITableView *mainView;
}

@property (nonatomic, copy) void (^completionBlock)(NSString *country, NSString *code);
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
