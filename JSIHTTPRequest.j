//
//  JSIHTTPRequest.h
//
//  Created by Michael Dales on 07/06/2011.
//  Copyright 2011 Digital Flapjack Ltd. All rights reserved.
//

@import <Foundation/CPObject.j>

@implementation JSIHTTPRequest: CPObject
{
    var _url                    @accessors(property=url);
    var _delegate               @accessors(property=delegate);
    var _responseString         @accessors(property=responseString);
    var _didFinishSelector      @accessors(property=didFinishSelector);
    var _didFailSelector        @accessors(property=didFailSelector);
    var _error                  @accessors(property=error);
    var _userInfo               @accessors(property=userInfo);
    
    var _connection;
    var _request;
}


///////////////////////////////////////////////////////////////////////////////
//
- (id)initWithURL: (CPString)url
{
    if (self = [super init]) 
    {
        _request = [CPURLRequest requestWithURL: url];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////
//
- (void)connection: (CPURLConnection)connection
    didReceiveData: (CPString)data
{
    _responseString = data;
    
    if (_delegate == nil)
        return;
        
    if (_didFinishSelector)
    {
        [_delegate performSelector: _didFinishSelector
            withObject: self];
    }
    else
    {
        if ([_delegate respondsToSelector: @selector(requestDidFinish:)])
        {
            [_delegate requestDidFinish: self];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////
//
- (void)connection: (CPURLConnection)connection
  didFailWithError: (CPString)exception
{
    _error=exception;
    
    if (_delegate == nil)
        return;
        
    if (_didFailSelector)
    {
        [_delegate performSelector: _didFailSelector
            withObject: self];
    }
    else
    {
        if ([_delegate respondsToSelector: @selector(requestDidFail:)])
        {
            [_delegate requestDidFail: self];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////
//
- (void)startAsynchronous
{    
    _connection = [CPURLConnection connectionWithRequest: _request delegate: self];   
}