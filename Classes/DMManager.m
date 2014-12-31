//
//  DMManager.m
//  MSDCatalog
//
//  Created by Alexandr Zhovty on 09.02.13.
//  Copyright (c) 2013 Alex. All rights reserved.
//

#import "DMManager.h"


@implementation DMManager
{
    BOOL _isLoading;
}

@synthesize defaultContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;




#pragma mark - Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        _dataBaseName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"];
    }
    return self;
}


+ (DMManager *)sharedManager
{
    static dispatch_once_t once;
    static DMManager *__instance;
    dispatch_once(&once, ^ { __instance = [[DMManager alloc] init]; });
    return __instance;
}

+ (NSManagedObjectContext *)managedObjectContext
{
    return [[DMManager sharedManager] defaultContext];
}

- (NSURL *)storeURL
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [url URLByAppendingPathComponent:[self.dataBaseName stringByAppendingString:@".sqlite"]];
}


#pragma mark - Core Data stack
- (NSManagedObjectContext *)defaultContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.dataBaseName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [self storeURL];
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = self.defaultContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
        }
    }
}

#pragma mark - Serialization
+ (BOOL)serializeDataDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    
    return YES;
    
}

@end
