//
//  MJViewController.m
//  UITableView-编辑模式
//
//  Created by 朱正晶 on 15/2/22.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "MJViewController.h"
#import "Person.h"


@interface MJViewController () <UITableViewDataSource>
@property NSMutableArray *Persons;
- (IBAction)remove:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _Persons = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++) {
        Person *p = [[Person alloc] init];
        p.name = [NSString stringWithFormat:@"Person -- %d", i];
        p.phone = [NSString stringWithFormat:@"%d", 10000 + arc4random_uniform(1000000)];
        [_Persons addObject:p];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _Persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    Person *s = _Persons[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [s name];
    cell.detailTextLabel.text = [s phone];
    
    return cell;
}

- (IBAction)remove:(id)sender
{
    BOOL delete = !_tableView.editing;
    [_tableView setEditing:delete animated:YES];
}

// 代理方法，点击删除按钮激活
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete) return;
    
    [_Persons removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
}

// 实现了这个代理方法，那么在点击删除按钮时左边会自动产生滑动按钮
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 更新数据源
    Person *p = _Persons[sourceIndexPath.row];
    
    [_Persons removeObject:p];
    [_Persons insertObject:p atIndex:destinationIndexPath.row];
}


@end



