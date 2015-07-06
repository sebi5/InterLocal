//
//  SignupOptions.m
//  PenPalApp2.3
//
//  Created by Computer on 4/13/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "SignupOptions.h"
#import "SignupPage.h"

NSUInteger gV_region = 0;
NSString *gV_region_list = @"";
NSString *gV_city_list = @"";
NSUInteger countryAtIndex = 0;
NSArray *gV_regions = nil;

@interface SignupOptions ()
@property (nonatomic, strong) NSMutableData *responseData;

@property(nonatomic,strong)NSMutableArray * dictCountryAndCode;
@property(nonatomic,strong)NSMutableArray *alphabetsArray;
@property(nonatomic,strong) NSMutableArray *indexArray;
@end

@implementation SignupOptions
@synthesize responseData = _responseData;

//@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupIndex];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //[self performSelector:@selector(doScrolling) withObject:nil afterDelay:0.3];
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    [self.view addSubview:mainView];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelItem;

    
}

- (void)doScrolling
{
    //[(UITableView *)self.view scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:34 inSection:0 ] atScrollPosition:0 animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    switch (pageListID) {
        case 105:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"This can not be changed after signing up."
                                  message: nil
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
           
            break;
        }
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    gV_region = 0;
    gV_regions = nil;
     [mainView reloadData];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    //NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    
    NSArray *res_arr = [res objectForKey:@"data"];
    NSDictionary *real_res = [res_arr objectAtIndex:0];
    NSString *code = [real_res objectForKey:@"code"];
    NSArray *regions = [real_res objectForKey:@"regions"];
    NSString *success = [real_res objectForKey:@"success"];
    
    if ([code isEqualToString:@"0"]) {
        gV_region = [regions count];
        gV_regions = regions;
    }
    else{
        gV_region = 0;
        gV_regions = nil;
    }
    

    [mainView reloadData];
 
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    
    switch (pageListID) {
        case 105:
        {
            self.navigationItem.title = NSLocalizedString(@"Gender", nil);
            break;
        }
        case 106:
        {
            self.navigationItem.title = NSLocalizedString(@"Country", nil);
            break;
        }
        case 107:
        {
            self.navigationItem.title = NSLocalizedString(@"Region", nil);
            
            self.responseData = [NSMutableData data];
  
            
            NSString *Country = [[NSUserDefaults standardUserDefaults] stringForKey:@"Country"];
            NSString *finString = [NSString stringWithFormat:@"http://45.55.157.207/python/Locations/regions.py?country=%@", Country];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:finString]];
            [request setHTTPMethod:@"GET"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            //[request setHTTPBody:postData];
            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            
           
            break;
        }
        default:
            break;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    
    switch (pageListID) {
        case 106:
        {
            return self.indexArray.count;
            
        }
            break;
        default:
        {
            return 1;
        }
            break;
            
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    // Return the number of rows in the section.
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    NSString* Country_text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Country_text"];
    NSString* Region_text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Region_text"];
    
    
    
    switch (pageListID) {
        case 105:
            return 2; // Gender
            break;
        case 106:
        {
            NSDictionary *dict = ((NSDictionary *)[self.indexArray objectAtIndex:section]);
            
            return ((NSArray *)([dict valueForKey:[[dict allKeys] objectAtIndex:0]])).count;
            // Country
        }
            break;
        case 107:
        {
            // Region
            if (([Country_text length] == 0)) {
                return 0;
            }
            return gV_region;
            break;
        }
        case 108:
        {
            // City: only display if country and region have been set
            if (([Country_text length] == 0) || ([Region_text length] == 0)) {
                return 0;
            }
            return 3;
            break;
        }
        default:
            return 0;
    }
    
    
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    
    NSString* listData = @"";
    //NSArray* parts = nil; //[listData componentsSeparatedByString: @","];
    
    switch (pageListID) {
        case 105:
        {
            listData = NSLocalizedString(@"Male,Female", nil); 
            NSString *Gender = [[NSUserDefaults standardUserDefaults] stringForKey:@"Gender"];
            NSIndexPath *path = [NSIndexPath indexPathForRow:[Gender intValue] inSection:0];
            NSArray* parts = [listData componentsSeparatedByString: @","];
            cell.textLabel.text = [parts objectAtIndex:indexPath.row];
            
            if([indexPath isEqual:path] && [Gender length] != 0){cell.accessoryType = UITableViewCellAccessoryCheckmark;}
            else{cell.accessoryType = UITableViewCellAccessoryNone;}
            break;
        }
        case 106:
        {
            
            
            NSDictionary *dict = ((NSDictionary *)[self.indexArray objectAtIndex:indexPath.section]);
            
            
           // NSLog(@" dictionary  :%@",dict);
           // NSLog(@"dict with key vlaue :%@",[dict objectForKey:[[dict allKeys]objectAtIndex:0]]);
            
            listData=[[dict objectForKey:[[dict allKeys]objectAtIndex:0]] componentsJoinedByString:@","];
            NSArray* parts = [listData componentsSeparatedByString: @","];
            cell.textLabel.text = [parts objectAtIndex:indexPath.row];
            
            NSString *Country = [[NSUserDefaults standardUserDefaults] stringForKey:@"Country"];
            NSIndexPath *path = [NSIndexPath indexPathForRow:[Country intValue] inSection:0];
            if([indexPath isEqual:path] && [Country length] != 0){cell.accessoryType = UITableViewCellAccessoryCheckmark;}
            else{cell.accessoryType = UITableViewCellAccessoryNone;}
            //[tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
            break;
        }
        case 107:
        {
            // will need to make sub switch or load from web
            listData = NSLocalizedString(gV_region_list, nil);
            NSArray* parts = gV_regions; //[listData componentsSeparatedByString: @","];
            cell.textLabel.text = [parts objectAtIndex:indexPath.row];
            NSString *Region = [[NSUserDefaults standardUserDefaults] stringForKey:@"Region"];
            NSIndexPath *path = [NSIndexPath indexPathForRow:[Region intValue] inSection:0];
            if([indexPath isEqual:path] && [Region length] != 0){cell.accessoryType = UITableViewCellAccessoryCheckmark;}
            else{cell.accessoryType = UITableViewCellAccessoryNone;}
            break;
        }
        case 108:
        {
            listData = NSLocalizedString(@"", nil);
            NSArray* parts = [listData componentsSeparatedByString: @","];
            cell.textLabel.text = [parts objectAtIndex:indexPath.row];
            break;
        }
            
        default:{
            NSArray* parts = 0;
            cell.textLabel.text = [parts objectAtIndex:indexPath.row];
            break;
        }
    }
    
#pragma - might make parts a global veriable
    
    
    //countryCount = [@([parts count]) stringValue];
    //countryCount = [NSString stringWithFormat: @"%ld", (long)[parts count]];
    
    //cell.textLabel.text = [parts objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    return cell;
}



-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    
    switch (pageListID) {
        case 105:
        {
            [[NSUserDefaults standardUserDefaults] setObject:cell.textLabel.text forKey:@"Gender_text"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"Gender"];
            break;
        }
        case 106:
        {
            [[NSUserDefaults standardUserDefaults] setObject:cell.textLabel.text forKey:@"Country_text"];
            
            NSUInteger countryIndex = [self.dictCountryAndCode indexOfObject: cell.textLabel.text];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)countryIndex] forKey:@"Country"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Region_text"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Region"];
            break;
        }
        case 107:
        {
            [[NSUserDefaults standardUserDefaults] setObject:cell.textLabel.text forKey:@"Region_text"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"Region"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        }
        case 108:
        {
            [[NSUserDefaults standardUserDefaults] setObject:cell.textLabel.text forKey:@"City_text"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"City"];
            break;
        }
            
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (self.completionBlock) {
        
        NSString *data = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
        self.completionBlock(data);
        
        NSLog(@"Data: %@", data);
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    
    switch (pageListID) {
        case 106:
        { NSMutableArray *ar = [NSMutableArray new];
            for (int i =0; i<self.indexArray.count; i++)
            {
                NSString *a = [[((NSDictionary *)[self.indexArray objectAtIndex:i]) allKeys]objectAtIndex:0];
                [ar addObject:a];
            }
            return ar;
            
        }
            break;
        default:
        {
            return nil;
        }
            break;
            
    }
    return nil;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *a = [[((NSDictionary *)[self.indexArray objectAtIndex:section]) allKeys]objectAtIndex:0];
    
    NSInteger pageListID = [[NSUserDefaults standardUserDefaults] integerForKey:@"pageListID"];
    
    if (pageListID == 106) {
        return a;
    }
    return nil;
}



////
#pragma - still need to add non a-z
-(void)setupIndex
{
    
    NSString *listData = NSLocalizedString(@"Afghanistan,Albania,Algeria,American Samoa,Andorra,Angola,Anguilla,Antigua and Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia and Herzegovina,Botswana,Brazil,British Virgin Islands,Brunei,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,Cape Verde,Cayman Islands,Central African Republic,Chad,Chile,China,Cocos Islands,Colombia,Comoros,Cook Islands,Costa Rica,Croatia,Cuba,Cyprus,Czech Republic,Democratic Republic of the Congo,Denmark,Djibouti,Dominica,Dominican Republic,East Timor,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,Estonia,Ethiopia,Falkland Islands,Faroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,French Southern Territories,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,Guam,Guatemala,Guernsey,Guinea,Guinea-Bissau,Guyana,Haiti,Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Iran,Iraq,Ireland,Isle of Man,Israel,Italy,Ivory Coast,Jamaica,Japan,Jersey,Jordan,Kazakhstan,Kenya,Kiribati,Kuwait,Kyrgyzstan,Laos,Latvia,Lebanon,Lesotho,Liberia,Libya,Liechtenstein,Lithuania,Luxembourg,Macao,Macedonia,Madagascar,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,Martinique,Mauritania,Mauritius,Mayotte,Mexico,Micronesia,Moldova,Monaco,Mongolia,Montenegro,Montserrat,Morocco,Mozambique,Myanmar,Namibia,Nepal,Netherlands,Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Niue,North Korea,Northern Mariana Islands,Norway,Oman,Pakistan,Palau,Palestinian Territory,Panama,Papua New Guinea,Paraguay,Peru,Philippines,Poland,Portugal,Puerto Rico,Qatar,Republic of the Congo,Reunion,Romania,Russia,Rwanda,Saint Barthélemy,Saint Helena,Saint Kitts and Nevis,Saint Lucia,Saint Martin,Saint Pierre and Miquelon,Saint Vincent and the Grenadines,Samoa,San Marino,Sao Tome and Principe,Saudi Arabia,Senegal,Serbia,Seychelles,Sierra Leone,Singapore,Slovakia,Slovenia,Solomon Islands,Somalia,South Africa,South Korea,Spain,Sri Lanka,Sudan,Suriname,Svalbard and Jan Mayen,Swaziland,Sweden,Switzerland,Syria,Taiwan,Tajikistan,Tanzania,Thailand,Togo,Tonga,Trinidad and Tobago,Tunisia,Turkey,Turkmenistan,Turks and Caicos Islands,Tuvalu,U.S. Virgin Islands,Uganda,Ukraine,United Arab Emirates,United Kingdom,United States,Uruguay,Uzbekistan,Vanuatu,Vatican,Venezuela,Vietnam,Wallis and Futuna,Western Sahara,Yemen,Zambia,Zimbabwe", nil);
    
    
    NSArray* parts = [listData componentsSeparatedByString: @","];
    self.dictCountryAndCode = [NSMutableArray arrayWithArray:parts];
    
    self.alphabetsArray = [[NSMutableArray alloc] init];
    
    [self.alphabetsArray addObject:@"A"];
    [self.alphabetsArray addObject:@"B"];
    [self.alphabetsArray addObject:@"C"];
    [self.alphabetsArray addObject:@"D"];
    [self.alphabetsArray addObject:@"E"];
    [self.alphabetsArray addObject:@"F"];
    [self.alphabetsArray addObject:@"G"];
    [self.alphabetsArray addObject:@"H"];
    [self.alphabetsArray addObject:@"I"];
    [self.alphabetsArray addObject:@"J"];
    [self.alphabetsArray addObject:@"K"];
    [self.alphabetsArray addObject:@"L"];
    [self.alphabetsArray addObject:@"M"];
    [self.alphabetsArray addObject:@"N"];
    [self.alphabetsArray addObject:@"O"];
    [self.alphabetsArray addObject:@"P"];
    [self.alphabetsArray addObject:@"Q"];
    [self.alphabetsArray addObject:@"R"];
    [self.alphabetsArray addObject:@"S"];
    [self.alphabetsArray addObject:@"T"];
    [self.alphabetsArray addObject:@"U"];
    [self.alphabetsArray addObject:@"V"];
    [self.alphabetsArray addObject:@"W"];
    [self.alphabetsArray addObject:@"X"];
    [self.alphabetsArray addObject:@"Y"];
    [self.alphabetsArray addObject:@"Z"];
    [self.alphabetsArray addObject:@"#"];
    self.indexArray = [NSMutableArray new];
    
    for (int i = 0; i < self.alphabetsArray.count; i++)
    {
        NSString *key = [self.alphabetsArray objectAtIndex:i];
        @try {
            
            NSArray *filteredArr  =[self.dictCountryAndCode sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", key];
            
            NSArray *list = [filteredArr filteredArrayUsingPredicate:predicate];
            
            
            NSDictionary *dict =[NSDictionary dictionaryWithObject:list forKey:key];
            if (filteredArr.count) {
                [self.indexArray addObject:dict];
            }
            
        }
        @catch (NSException *exception)
        {
            NSLog(@"Exception is:%@",exception);
        }
        
    }
    [mainView reloadData];
    
    
    
}

- (IBAction)cancelButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
