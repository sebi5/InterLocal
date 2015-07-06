//  country

#import "SLCountryPickerViewController.h"

static NSString *CellIdentifier = @"CountryCell";
@interface SLCountryPickerViewController ()<UISearchDisplayDelegate, UISearchBarDelegate>
@property (nonatomic) UISearchDisplayController *searchController;
@end

@implementation SLCountryPickerViewController{
    NSMutableArray *_filteredList;
    NSArray *_sections;
    //UISearchBar * theSearchBar;
}

- (void)createSearchBar {
        if (mainView && !mainView.tableHeaderView) {
            UISearchBar *theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,40)]; // frame has no effect.
            theSearchBar.placeholder = NSLocalizedString(@"Search Country", nil);
            theSearchBar.delegate = self;
            //theSearchBar.showsCancelButton = YES;
            
            mainView.tableHeaderView = theSearchBar;
            
            UISearchDisplayController *searchCon = [[UISearchDisplayController alloc]
                                                    initWithSearchBar:theSearchBar
                                                    contentsController:self ];
          
            
            
            self.searchController = searchCon;
            _searchController.delegate = self;
            _searchController.searchResultsDataSource = self;
            _searchController.searchResultsDelegate = self;
            
            //[_searchController setActive:YES animated:YES];
            [theSearchBar becomeFirstResponder];
            //_searchController.displaysSearchBarInNavigationBar = YES;
        }
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    self.navigationItem.leftBarButtonItem = cancelItem;
   
    self.navigationItem.title = NSLocalizedString(@"Country", nil);
    
    //UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 28, self.view.frame.size.width, 44)];
    //[navBar setTintColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]];

    
   // UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
   // UINavigationController *tableViewNavigationController = [[UINavigationController alloc] initWithRootViewController:mainView];

    
    
     [self.view addSubview:mainView];
     //[self.view addSubview:navBar];
     [self createSearchBar];

    
    //UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Country"];
    //[navItem setLeftBarButtonItem:cancelItem animated:NO];
    //[navBar setItems:[NSArray arrayWithObject:navItem] animated:NO];
    
    
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    
    NSMutableArray *countriesUnsorted = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    _filteredList = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    
    for (NSString *countryCode in countryCodes) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        NSDictionary *cd = @{@"name": displayNameString, @"code":countryCode};
        [countriesUnsorted addObject:cd];
        
    }
    _sections = [self partitionObjects:countriesUnsorted collationStringSelector:@selector(self)];
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    
//    NSArray *sortDescriptors = @[sortDescriptor];
//    
//    countries = [countriesUnsorted sortedArrayUsingDescriptors:sortDescriptors];
//    [countries sortUsingSelector:@selector(localizedCompare:)];
    
    [mainView reloadData];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(preferredContentSizeChanged:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}
- (void)preferredContentSizeChanged:(NSNotification *)notification {
    [mainView reloadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

#pragma mark - Table view data source
-(NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSInteger sectionCount = [[collation sectionTitles] count];
    NSMutableArray *unsortedSections = [NSMutableArray arrayWithCapacity:sectionCount];
    
    for (int i = 0; i < sectionCount; i++) {
        [unsortedSections addObject:[NSMutableArray array]];
    }
    
    for (id object in array) {
        NSInteger index = [collation sectionForObject:object[@"name"] collationStringSelector:selector];
        [[unsortedSections objectAtIndex:index] addObject:object];
    }
    
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:sectionCount];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    
    for (NSMutableArray *section in unsortedSections) {
        NSArray *sortedArray = [section sortedArrayUsingDescriptors:sortDescriptors];
//        [collation sortedArrayFromArray:section collationStringSelector:selector]];
//    collationStringSelector:selector]];
        [sections addObject:sortedArray];
    }
    
    return sections;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [UILocalizedIndexedCollation.currentCollation sectionIndexTitles];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
    //we use sectionTitles and not sections
    return [[UILocalizedIndexedCollation.currentCollation sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [_filteredList count];
    }
    return [_sections[section] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    BOOL showSection = [[_sections objectAtIndex:section] count] != 0;
    //only show the section title if there are rows in the section
    return (showSection) ? [[UILocalizedIndexedCollation.currentCollation sectionTitles] objectAtIndex:section] : nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [mainView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *cd = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        cd = _filteredList[indexPath.row];
        
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:cd[@"name"] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.785 alpha:1.000], NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
        [attributedTitle addAttribute:NSForegroundColorAttributeName
                                value:[UIColor blackColor]
                                range:[attributedTitle.string.lowercaseString rangeOfString:_searchController.searchBar.text.lowercaseString]];
        
        cell.textLabel.attributedText = attributedTitle;
    }
	else
	{
        cd = _sections[indexPath.section][indexPath.row];
        
        cell.textLabel.text = cd[@"name"];
        cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }

    cell.imageView.image = [UIImage imageNamed:cd[@"code"]];
   //NSLog(@"%@", cd[@"code"]);
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    /*
    
    NSInteger rowNumber = 0;
    
    for (NSInteger i = 0; i < indexPath.section; i++) {
        rowNumber += [self tableView:tableView numberOfRowsInSection:i];
    }
    
    rowNumber += indexPath.row;
    
    NSLog(@"CC2: %ld", (long)rowNumber);
    
     */

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
    if (self.completionBlock) {
        NSDictionary *cd = nil;
        
        if(tableView == self.searchDisplayController.searchResultsTableView) {
            cd = _filteredList[indexPath.row];
        }
        else {
            cd = _sections[indexPath.section][indexPath.row];
        }
        self.completionBlock(cd[@"name"],cd[@"code"]); // [mainView numberOfSections]
        
        [[NSUserDefaults standardUserDefaults] setObject:cd[@"name"] forKey:@"Country_text"];
        
         NSLog(@"CC: %@", cd[@"code"]);
        
        
        //NSUInteger countryIndex = [cd indexOfObject: cd[@"code"]];
        
       [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",cd[@"code"]] forKey:@"Country"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Region_text"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Region"];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	[_filteredList removeAllObjects];
    
    for (NSArray *section in _sections) {
        for (NSDictionary *dict in section)
        {
                NSComparisonResult result = [dict[@"name"] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if (result == NSOrderedSame)
                {
                    [_filteredList addObject:dict];
                }
        }
    }
}
#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [self.searchDisplayController.searchBar scopeButtonTitles][[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [self.searchDisplayController.searchBar scopeButtonTitles][searchOption]];
    
    return YES;
}
#pragma mark - searchBar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

}

- (IBAction)cancelButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    mainView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 30;
    
    //return tableView.sectionHeaderHeight;
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //return tableView.sectionHeaderHeight;
    
    return 16;
}


@end
