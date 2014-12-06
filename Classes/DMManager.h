//
//  DMManager.h
//  MSDCatalog
//
//  Created by Александр Жовтый on 09.02.13.
//  Copyright (c) 2013 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DMManager : NSObject


@property (strong, nonatomic) NSString *dataBaseName;
@property (readonly, strong, nonatomic) NSManagedObjectContext * defaultContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

+ (DMManager *)sharedManager;
+ (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;

+ (BOOL)serializeDataDictionary:(NSDictionary *)dictionary error:(NSError **)error;

@end