//
//  Norms.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Norms.h"


NSString *const kNormsNormid = @"normid";
NSString *const kNormsNormtitle = @"normtitle";
NSString *const kNormsNormimagelist = @"normimagelist";


@interface Norms ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Norms

@synthesize normid = _normid;
@synthesize normtitle = _normtitle;
@synthesize normimagelist = _normimagelist;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.normid = [self objectOrNilForKey:kNormsNormid fromDictionary:dict];
            self.normtitle = [self objectOrNilForKey:kNormsNormtitle fromDictionary:dict];
            self.normimagelist = [self objectOrNilForKey:kNormsNormimagelist fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.normid forKey:kNormsNormid];
    [mutableDict setValue:self.normtitle forKey:kNormsNormtitle];
    NSMutableArray *tempArrayForNormimagelist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.normimagelist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNormimagelist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNormimagelist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNormimagelist] forKey:kNormsNormimagelist];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.normid = [aDecoder decodeObjectForKey:kNormsNormid];
    self.normtitle = [aDecoder decodeObjectForKey:kNormsNormtitle];
    self.normimagelist = [aDecoder decodeObjectForKey:kNormsNormimagelist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_normid forKey:kNormsNormid];
    [aCoder encodeObject:_normtitle forKey:kNormsNormtitle];
    [aCoder encodeObject:_normimagelist forKey:kNormsNormimagelist];
}

- (id)copyWithZone:(NSZone *)zone
{
    Norms *copy = [[Norms alloc] init];
    
    if (copy) {

        copy.normid = [self.normid copyWithZone:zone];
        copy.normtitle = [self.normtitle copyWithZone:zone];
        copy.normimagelist = [self.normimagelist copyWithZone:zone];
    }
    
    return copy;
}


@end
