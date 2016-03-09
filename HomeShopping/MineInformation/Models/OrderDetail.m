//
//  OrderDetail.m
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrderDetail.h"
#import "Address.h"
#import "OrderDetailproducts.h"


NSString *const kOrderDetailPaytime = @"paytime";
NSString *const kOrderDetailOrdernum = @"ordernum";
NSString *const kOrderDetailDiscount = @"discount";
NSString *const kOrderDetailPaytype = @"paytype";
NSString *const kOrderDetailBackcoints = @"backcoints";
NSString *const kOrderDetailUsecoints = @"usecoints";
NSString *const kOrderDetailProductcount = @"productcount";
NSString *const kOrderDetailSellerid = @"sellerid";
NSString *const kOrderDetailSellername = @"sellername";
NSString *const kOrderDetailOrderid = @"orderid";
NSString *const kOrderDetailBorndate = @"borndate";
NSString *const kOrderDetailAddress = @"address";
NSString *const kOrderDetailOrderDetailproducts = @"products";
NSString *const kOrderDetailTotalcost = @"totalcost";
NSString *const kOrderDetailSellerlogo = @"sellerlogo";
NSString *const kOrderDetailIscomment = @"iscomment";
NSString *const kOrderDetailPrepayid = @"prepayid";
NSString *const kOrderDetailStatus = @"status";
NSString *const kOrderDetailCost = @"cost";


@interface OrderDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderDetail

@synthesize paytime = _paytime;
@synthesize ordernum = _ordernum;
@synthesize discount = _discount;
@synthesize paytype = _paytype;
@synthesize backcoints = _backcoints;
@synthesize usecoints = _usecoints;
@synthesize productcount = _productcount;
@synthesize sellerid = _sellerid;
@synthesize sellername = _sellername;
@synthesize orderid = _orderid;
@synthesize borndate = _borndate;
@synthesize address = _address;
@synthesize orderDetailproducts = _orderDetailproducts;
@synthesize totalcost = _totalcost;
@synthesize sellerlogo = _sellerlogo;
@synthesize iscomment = _iscomment;
@synthesize prepayid = _prepayid;
@synthesize status = _status;
@synthesize cost = _cost;


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
            self.paytime = [self objectOrNilForKey:kOrderDetailPaytime fromDictionary:dict];
            self.ordernum = [self objectOrNilForKey:kOrderDetailOrdernum fromDictionary:dict];
            self.discount = [self objectOrNilForKey:kOrderDetailDiscount fromDictionary:dict];
            self.paytype = [self objectOrNilForKey:kOrderDetailPaytype fromDictionary:dict];
            self.backcoints = [self objectOrNilForKey:kOrderDetailBackcoints fromDictionary:dict];
            self.usecoints = [self objectOrNilForKey:kOrderDetailUsecoints fromDictionary:dict];
            self.productcount = [self objectOrNilForKey:kOrderDetailProductcount fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kOrderDetailSellerid fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kOrderDetailSellername fromDictionary:dict];
            self.orderid = [self objectOrNilForKey:kOrderDetailOrderid fromDictionary:dict];
            self.borndate = [self objectOrNilForKey:kOrderDetailBorndate fromDictionary:dict];
            self.address = [Address modelObjectWithDictionary:[dict objectForKey:kOrderDetailAddress]];
    NSObject *receivedOrderDetailproducts = [dict objectForKey:kOrderDetailOrderDetailproducts];
    NSMutableArray *parsedOrderDetailproducts = [NSMutableArray array];
    if ([receivedOrderDetailproducts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOrderDetailproducts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOrderDetailproducts addObject:[OrderDetailproducts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOrderDetailproducts isKindOfClass:[NSDictionary class]]) {
       [parsedOrderDetailproducts addObject:[OrderDetailproducts modelObjectWithDictionary:(NSDictionary *)receivedOrderDetailproducts]];
    }

    self.orderDetailproducts = [NSArray arrayWithArray:parsedOrderDetailproducts];
            self.totalcost = [self objectOrNilForKey:kOrderDetailTotalcost fromDictionary:dict];
            self.sellerlogo = [self objectOrNilForKey:kOrderDetailSellerlogo fromDictionary:dict];
            self.iscomment = [self objectOrNilForKey:kOrderDetailIscomment fromDictionary:dict];
            self.prepayid = [self objectOrNilForKey:kOrderDetailPrepayid fromDictionary:dict];
            self.status = [self objectOrNilForKey:kOrderDetailStatus fromDictionary:dict];
            self.cost = [self objectOrNilForKey:kOrderDetailCost fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.paytime forKey:kOrderDetailPaytime];
    [mutableDict setValue:self.ordernum forKey:kOrderDetailOrdernum];
    [mutableDict setValue:self.discount forKey:kOrderDetailDiscount];
    [mutableDict setValue:self.paytype forKey:kOrderDetailPaytype];
    [mutableDict setValue:self.backcoints forKey:kOrderDetailBackcoints];
    [mutableDict setValue:self.usecoints forKey:kOrderDetailUsecoints];
    [mutableDict setValue:self.productcount forKey:kOrderDetailProductcount];
    [mutableDict setValue:self.sellerid forKey:kOrderDetailSellerid];
    [mutableDict setValue:self.sellername forKey:kOrderDetailSellername];
    [mutableDict setValue:self.orderid forKey:kOrderDetailOrderid];
    [mutableDict setValue:self.borndate forKey:kOrderDetailBorndate];
    [mutableDict setValue:[self.address dictionaryRepresentation] forKey:kOrderDetailAddress];
    NSMutableArray *tempArrayForOrderDetailproducts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.orderDetailproducts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOrderDetailproducts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOrderDetailproducts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOrderDetailproducts] forKey:kOrderDetailOrderDetailproducts];
    [mutableDict setValue:self.totalcost forKey:kOrderDetailTotalcost];
    [mutableDict setValue:self.sellerlogo forKey:kOrderDetailSellerlogo];
    [mutableDict setValue:self.iscomment forKey:kOrderDetailIscomment];
    [mutableDict setValue:self.prepayid forKey:kOrderDetailPrepayid];
    [mutableDict setValue:self.status forKey:kOrderDetailStatus];
    [mutableDict setValue:self.cost forKey:kOrderDetailCost];

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

    self.paytime = [aDecoder decodeObjectForKey:kOrderDetailPaytime];
    self.ordernum = [aDecoder decodeObjectForKey:kOrderDetailOrdernum];
    self.discount = [aDecoder decodeObjectForKey:kOrderDetailDiscount];
    self.paytype = [aDecoder decodeObjectForKey:kOrderDetailPaytype];
    self.backcoints = [aDecoder decodeObjectForKey:kOrderDetailBackcoints];
    self.usecoints = [aDecoder decodeObjectForKey:kOrderDetailUsecoints];
    self.productcount = [aDecoder decodeObjectForKey:kOrderDetailProductcount];
    self.sellerid = [aDecoder decodeObjectForKey:kOrderDetailSellerid];
    self.sellername = [aDecoder decodeObjectForKey:kOrderDetailSellername];
    self.orderid = [aDecoder decodeObjectForKey:kOrderDetailOrderid];
    self.borndate = [aDecoder decodeObjectForKey:kOrderDetailBorndate];
    self.address = [aDecoder decodeObjectForKey:kOrderDetailAddress];
    self.orderDetailproducts = [aDecoder decodeObjectForKey:kOrderDetailOrderDetailproducts];
    self.totalcost = [aDecoder decodeObjectForKey:kOrderDetailTotalcost];
    self.sellerlogo = [aDecoder decodeObjectForKey:kOrderDetailSellerlogo];
    self.iscomment = [aDecoder decodeObjectForKey:kOrderDetailIscomment];
    self.prepayid = [aDecoder decodeObjectForKey:kOrderDetailPrepayid];
    self.status = [aDecoder decodeObjectForKey:kOrderDetailStatus];
    self.cost = [aDecoder decodeObjectForKey:kOrderDetailCost];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_paytime forKey:kOrderDetailPaytime];
    [aCoder encodeObject:_ordernum forKey:kOrderDetailOrdernum];
    [aCoder encodeObject:_discount forKey:kOrderDetailDiscount];
    [aCoder encodeObject:_paytype forKey:kOrderDetailPaytype];
    [aCoder encodeObject:_backcoints forKey:kOrderDetailBackcoints];
    [aCoder encodeObject:_usecoints forKey:kOrderDetailUsecoints];
    [aCoder encodeObject:_productcount forKey:kOrderDetailProductcount];
    [aCoder encodeObject:_sellerid forKey:kOrderDetailSellerid];
    [aCoder encodeObject:_sellername forKey:kOrderDetailSellername];
    [aCoder encodeObject:_orderid forKey:kOrderDetailOrderid];
    [aCoder encodeObject:_borndate forKey:kOrderDetailBorndate];
    [aCoder encodeObject:_address forKey:kOrderDetailAddress];
    [aCoder encodeObject:_orderDetailproducts forKey:kOrderDetailOrderDetailproducts];
    [aCoder encodeObject:_totalcost forKey:kOrderDetailTotalcost];
    [aCoder encodeObject:_sellerlogo forKey:kOrderDetailSellerlogo];
    [aCoder encodeObject:_iscomment forKey:kOrderDetailIscomment];
    [aCoder encodeObject:_prepayid forKey:kOrderDetailPrepayid];
    [aCoder encodeObject:_status forKey:kOrderDetailStatus];
    [aCoder encodeObject:_cost forKey:kOrderDetailCost];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderDetail *copy = [[OrderDetail alloc] init];
    
    if (copy) {

        copy.paytime = [self.paytime copyWithZone:zone];
        copy.ordernum = [self.ordernum copyWithZone:zone];
        copy.discount = [self.discount copyWithZone:zone];
        copy.paytype = [self.paytype copyWithZone:zone];
        copy.backcoints = [self.backcoints copyWithZone:zone];
        copy.usecoints = [self.usecoints copyWithZone:zone];
        copy.productcount = [self.productcount copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.orderid = [self.orderid copyWithZone:zone];
        copy.borndate = [self.borndate copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.orderDetailproducts = [self.orderDetailproducts copyWithZone:zone];
        copy.totalcost = [self.totalcost copyWithZone:zone];
        copy.sellerlogo = [self.sellerlogo copyWithZone:zone];
        copy.iscomment = [self.iscomment copyWithZone:zone];
        copy.prepayid = [self.prepayid copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.cost = [self.cost copyWithZone:zone];
    }
    
    return copy;
}


@end
