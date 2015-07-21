//
//  Example2Controller.m
//  DemoBackgroundLocationUpdate
//
//  Created by Ralph Li on 7/20/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "Example2Controller.h"
#import <Realm/Realm.h>
#import <Masonry/Masonry.h>
#import "MMLoc.h"

@interface Example2Controller ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RLMResults *locArray;

@property (nonatomic, strong) RLMNotificationToken *token;


@property (nonatomic, strong) UIButton *clearButton;

@end

@implementation Example2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locArray = [[MMLoc allObjects] sortedResultsUsingProperty:@"date" ascending:NO];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.clearButton];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 0, 20));
        make.height.equalTo(@40);
    }];
    [self.clearButton setTitle:@"clear data" forState:UIControlStateNormal];
    [self.clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(actionClear) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    __weak __typeof(&*self)ws = self;
    self.token = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        
        ws.locArray = [[MMLoc allObjects] sortedResultsUsingProperty:@"date" ascending:NO];
        
        [ws.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionClear
{
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteAllObjects];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    MMLoc *loc = [self.locArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [loc.date description];
    cell.detailTextLabel.text = loc.loc;
    cell.textLabel.textColor = loc.background?[UIColor redColor]:[UIColor blueColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
