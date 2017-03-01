//
//  ViewController.m
//  HNLVideo
//
//  Created by 谢印超 on 2017/2/21.
//  Copyright © 2017年 谢印超. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Tutorial+CoreDataClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *modeUrl = [[NSBundle mainBundle] URLForResource:@"HNLVideo" withExtension:@"momd"];
    
    //创建数据模型，相当于数据库，或者说数据模型合集
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modeUrl];
    
    // 创建持久化协调者：相当于绑定需要操作的数据库 mom 模型（这样说有助于你们的理解吧！）
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    //定义数据库存放路径
    NSURL *path = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"HNL.sqlite"]];
    
    //为持久化对象建立数据接收栈：也就是为持久化对象绑定数据库存储地址,没有数据库会创建，有则直接修改更新数据库
    //怎么更新？ 因为之前已经持久化绑定数据库模型了，所以模型中的数据结构和数据库中的数据表是一一对应的！
    /*
         可以支持的类型如下：
          NSString * const NSSQLiteStoreType;//sqlite
          NSString * const NSXMLStoreType;//XML
          NSString * const NSBinaryStoreType;//二进制
          NSString * const NSInMemoryStoreType;//内存
         */
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:path options:nil error:nil];
    
    //创建数据管理上下文对象：数据库协调者类似一个协议类，绑定了数据模型，数据存储的位置，而真正实现数据库操作的是context对象！如 ：增，删，改，查。所以，context 需要持有持久化对象来操作数据
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    
    // 以上步骤是调动基础服务，接下来创建实际的数据对象NSEntityDescription,设置数据后，并存储到数据库
    // 数据对象与之前创建的数据模型有关，因为数据模型中存储了 我们需要的数据结构，所以我们可以通过实体名字（表名）
    // 来获取数据对象
    
    // 这个时候只是通过Mmoc 把新建的 模型对象 Tutorial，临时放入内存（这是context和协调者的功劳）
    Tutorial *tutor = [NSEntityDescription insertNewObjectForEntityForName:@"Tutorial" inManagedObjectContext:moc];
    
    tutor.title = @"titlesssss";
    tutor.star = 30;
    tutor.collect = 20;
    tutor.comment = 4;
    
    //存储
    if([moc save:nil]) {
        NSLog(@"save success!");
    }
    

    NSLog(@"%@",[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject] stringByAppendingPathComponent:@"HNL.sqlite"]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
