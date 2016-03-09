//
//  Orders.m
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Orders.h"
#import "Products.h"


NSString *const kOrdersBackcoints = @"backcoints";
NSString *const kOrdersOrdernum = @"ordernum";
NSString *const kOrdersCost = @"cost";
NSString *const kOrdersUsecoints = @"usecoints";
NSString *const kOrdersProducttype = @"producttype";
NSString *const kOrdersSellerid = @"sellerid";
NSString *const kOrdersSellername = @"sellername";
NSString *const kOrdersOrderid = @"orderid";
NSString *const kOrdersBorndate = @"borndate";
NSString *const kOrdersProducts = @"products";
NSString *const kOrdersSellerlogo = @"sellerlogo";
NSString *const kOrdersPrepayid = @"prepayid";
NSString *const kOrdersStatus = @"status";
NSString *const kOrdersProductcount = @"productcount";


@interface Orders ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Orders

@synthesize backcoints = _backcoints;
@synthesize ordernum = _ordernum;
@synthesize cost = _cost;
@synthesize usecoints = _usecoints;
@synthesize producttype = _producttype;
@synthesize sellerid = _sellerid;
@synthesize sellername = _sellername;
@synthesize orderid = _orderid;
@synthesize borndate = _borndate;
@synthesize products = _products;
@synthesize sellerlogo = _sellerlogo;
@synthesize prepayid = _prepayid;
@synthesize status = _status;
@synthesize productcount = _productcount;


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
            self.backcoints = [self objectOrNilForKey:kOrdersBackcoints fromDictionary:dict];
            self.ordernum = [self objectOrNilForKey:kOrdersOrdernum fromDictionary:dict];
            self.cost = [self objectOrNilForKey:kOrdersCost fromDictionary:dict];
            self.usecoints = [self objectOrNilForKey:kOrdersUsecoints fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kOrdersProducttype fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kOrdersSellerid fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kOrdersSellername fromDictionary:dict];
            self.orderid = [self objectOrNilForKey:kOrdersOrderid fromDictionary:dict];
            self.borndate = [self objectOrNilForKey:kOrdersBorndate fromDictionary:dict];
    NSObject *receivedProducts = [dict objectForKey:kOrdersProducts];
    NSMutableArray *parsedProducts = [NSMutableArray array];
    if ([receivedProducts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedProducts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedProducts addObject:[Products modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedProducts isKindOfClass:[NSDictionary class]]) {
       [parsedProducts addObject:[Products modelObjectWithDictionary:(NSDictionary *)receivedProducts]];
    }

    self.products = [NSArray arrayWithArray:parsedProducts];
            self.sellerlogo = [self objectOrNilForKey:kOrdersSellerlogo fromDictionary:dict];
            self.prepayid = [self objectOrNilForKey:kOrdersPrepayid fromDictionary:dict];
            self.status = [self objectOrNilForKey:kOrdersStatus fromDictionary:dict];
            self.productcount = [self objectOrNilForKey:kOrdersProductcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.backcoints forKey:kOrdersBackcoints];
    [mutableDict setValue:self.ordernum forKey:kOrdersOrdernum];
    [mutableDict setValue:self.cost forKey:kOrdersCost];
    [mutableDict setValue:self.usecoints forKey:kOrdersUsecoints];
    [mutableDict setValue:self.producttype forKey:kOrdersProducttype];
    [mutableDict setValue:self.sellerid forKey:kOrdersSellerid];
    [mutableDict setValue:self.sellername forKey:kOrdersSellername];
    [mutableDict setValue:self.orderid forKey:kOrdersOrderid];
    [mutableDict setValue:self.borndate forKey:kOrdersBorndate];
    NSMutableArray *tempArrayForProducts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.products) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProducts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProducts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProducts] forKey:kOrdersProducts];
    [mutableDict setValue:self.sellerlogo forKey:kOrdersSellerlogo];
    [mutableDict setValue:self.prepayid forKey:kOrdersPrepayid];
    [mutableDict setValue:self.status forKey:kOrdersStatus];
    [mutableDict setValue:self.productcount forKey:kOrdersProductcount];

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

    self.backcoints = [aDecoder decodeObjectForKey:kOrdersBackcoints];
    self.ordernum = [aDecoder decodeObjectForKey:kOrdersOrdernum];
    self.cost = [aDecoder decodeObjectForKey:kOrdersCost];
    self.usecoints = [aDecoder decodeObjectForKey:kOrdersUsecoints];
    self.producttype = [aDecoder decodeObjectForKey:kOrdersProducttype];
    self.sellerid = [aDecoder decodeObjectForKey:kOrdersSellerid];
    self.sellername = [aDecoder decodeObjectForKey:kOrdersSellername];
    self.orderid = [aDecoder decodeObjectForKey:kOrdersOrderid];
    self.borndate = [aDecoder decodeObjectForKey:kOrdersBorndate];
    self.products = [aDecoder decodeObjectForKey:kOrdersProducts];
    self.sellerlogo = [aDecoder decodeObjectForKey:kOrdersSellerlogo];
    self.prepayid = [aDecoder decodeObjectForKey:kOrdersPrepayid];
    self.status = [aDecoder decodeObjectForKey:kOrdersStatus];
    self.productcount = [aDecoder decodeObjectForKey:kOrdersProductcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_backcoints forKey:kOrdersBackcoints];
    [aCoder encodeObject:_ordernum forKey:kOrdersOrdernum];
    [aCoder encodeObject:_cost forKey:kOrdersCost];
    [aCoder encodeObject:_usecoints forKey:kOrdersUsecoints];
    [aCoder encodeObject:_producttype forKey:kOrdersProducttype];
    [aCoder encodeObject:_sellerid forKey:kOrdersSellerid];
    [aCoder encodeObject:_sellername forKey:kOrdersSellername];
    [aCoder encodeObject:_orderid forKey:kOrdersOrderid];
    [aCoder encodeObject:_borndate forKey:kOrdersBorndate];
    [aCoder encodeObject:_products forKey:kOrdersProducts];
    [aCoder encodeObject:_sellerlogo forKey:kOrdersSellerlogo];
    [aCoder encodeObject:_prepayid forKey:kOrdersPrepayid];
    [aCoder encodeObject:_status forKey:kOrdersStatus];
    [aCoder encodeObject:_productcount forKey:kOrdersProductcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    Orders *copy = [[Orders alloc] init];
    
    if (copy) {

        copy.backcoints = [self.backcoints copyWithZone:zone];
        copy.ordernum = [self.ordernum copyWithZone:zone];
        copy.cost = [self.cost copyWithZone:zone];
        copy.usecoints = [self.usecoints copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.orderid = [self.orderid copyWithZone:zone];
        copy.borndate = [self.borndate copyWithZone:zone];
        copy.products = [self.products copyWithZone:zone];
        copy.sellerlogo = [self.sellerlogo copyWithZone:zone];
        copy.prepayid = [self.prepayid copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.productcount = [self.productcount copyWithZone:zone];
    }
    
    return copy;
}


@end
