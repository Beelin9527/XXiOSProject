//
//  XXRealmController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/20.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXRealmController.h"

#import "XXRealmPersonModel.h"

#import <Realm.h>

@interface XXRealmController ()
@property (strong, nonatomic) UIButton *insertBtn;

@property (nonatomic, strong) RLMNotificationToken *token;

@end

@implementation XXRealmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.insertBtn];
    
//    [self creatDataBaseWithName:@"RealmTestDB.realm"];
   
    
    //每当一次写事务完成Realm实例都会向其他线程上的实例发出通知，可以通过注册一个block来响应通知：
    RLMRealm *realm = [RLMRealm defaultRealm];
    self.token = [realm addNotificationBlock:^(NSString *note, RLMRealm * realm) {
        NSLog(@"note: %@, realm: %@", note, realm);
    }];
    
}



/*
 增
 说明：对于增加、删除、修改必须要在事务中进行操作。
 */
- (void)insertRealm {
    XXRealmPersonModel *p = [[XXRealmPersonModel alloc] init];
    p.id = [NSUUID UUID].UUIDString;
    p.name = @"Beelin";
    p.age = 27;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addObject:p];
        }];
    });
    
}

/* 删 */
- (void)deleteRealm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];

}
/* 查 */
- (void)queryRealm {
    RLMResults<XXRealmPersonModel *> *r = [XXRealmPersonModel objectsWhere:@"name = 'Beelin1'"];
    for (XXRealmPersonModel *p in r) {
        NSLog(@"name:%@， age:%ld", p.name, p.age);
    }
    /*
     2）条件查询
     RLMResults *results = [Article objectsWhere:@"..."];
     也可以使用谓词查询：
     NSPredicate *pred = [NSPredicate predicateWithFormat:@"..."];
     RLMResults *results = [Article objectsWithPredicate:pred];
     
     3）条件排序
     RLMResults *results = [[Article objectsWhere:@"..."] sortedResultsUsingProperty:@"num" ascending:YES];
     
     4）链式查询(结果过滤)
     RLMResults *results1 = [Article objectsWhere:@"..."];
     RLMResults *results2 = [results1 objectsWhere:@"..."];
     */
}

/* 改 */
- (void)updateRealm {
    RLMResults<XXRealmPersonModel *> *r = [XXRealmPersonModel objectsWhere:@"name = 'Beelin' and age = 27"];
    XXRealmPersonModel *p = r.firstObject;
    p.age = 28;
    
     RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:p];
    [realm commitWriteTransaction];
//    [realm transactionWithBlock:^{
//        [realm addOrUpdateObject:p];
//    }];
}

- (void)creatDataBaseWithName:(NSString *)databaseName {
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL fileURLWithPath:filePath];
//    config.objectClasses = @[MyClass.class, MyOtherClass.class];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {
        // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
        }
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    /*
    objectClasses这个属性是用来控制对哪个类能够存储在指定 Realm 数据库中做出限制。例如，如果有两个团队分别负责开发您应用中的不同部分，并且同时在应用内部使用了 Realm 数据库，那么您肯定不希望为它们协调进行数据迁移您可以通过设置RLMRealmConfiguration的 objectClasses属性来对类做出限制。objectClasses一般可以不用设置。
     
     
     ## 特殊的数据库，内存数据库。
     通常情况下，Realm 数据库是存储在硬盘中的，但是您能够通过设置inMemoryIdentifier而不是设置RLMRealmConfiguration中的 fileURL属性，以创建一个完全在内存中运行的数据库。
     RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
     config.inMemoryIdentifier = @"MyInMemoryRealm";
     RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    */

    
}


- (void)insertAction {
    [self insertRealm];
}

- (UIButton *)insertBtn {
    if (!_insertBtn) {
        _insertBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _insertBtn.frame = CGRectMake(50, 100, 100, 50);
        [_insertBtn setTitle:@"增" forState:UIControlStateNormal];
        [_insertBtn addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insertBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
