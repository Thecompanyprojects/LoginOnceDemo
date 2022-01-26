//
//  CertificationVC.m
//  LoginDemo
//
//  Created by 王俊钢 on 2021/11/3.
//

#import "CertificationVC.h"

@interface CertificationVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITextField *schoolText;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation CertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.schoolText];
    [self.view addSubview:self.tableView];
    self.dataSource = [NSMutableArray new];

    for (int i = 0; i<20; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.tableView reloadData];
}

#pragma mark - getters

-(UITextField *)schoolText
{
    if(!_schoolText)
    {
        _schoolText = [UITextField new];
        _schoolText.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, 46);
        _schoolText.layer.masksToBounds = true;
        _schoolText.layer.cornerRadius = 8;
        _schoolText.layer.borderWidth = 1;
        _schoolText.layer.borderColor = [UIColor grayColor].CGColor;
        _schoolText.delegate = self;
        // 1.给textField增加事件
        [_schoolText addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

    }
    return _schoolText;
}



// 2.回调
- (void)textFieldChanged:(UITextView *)textField
{
    NSString *text = textField.text;
    NSLog(@"inputString: %@", text);
    if (text.length!=0) {
        [self.tableView setHidden:false];
    }
    else{
        [self.tableView setHidden:true];
    }
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width-40, 200);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setHidden:true];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count?:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return  cell;
}

@end
