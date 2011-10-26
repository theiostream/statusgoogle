#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 28.0f

@interface UIApplication (theiostream)
- (void)applicationOpenURL:(id)url;
@end

@interface UIDevice (theiostream)
- (BOOL)isWildcat;
@end

@interface StatusGoogleController : NSObject <BBWeeAppController, UITextFieldDelegate>
{
	UIView *_view;
	UITextField *searchField;
	NSString *google;
	NSString *googleSearch;
}

@end

@implementation StatusGoogleController

- (id)init
{
	if ((self = [super init]))
	{
		
	}
	return self;
}

- (void)dealloc {
	[_view release];
	[super dealloc];
}

- (UIView *)view
{
	if (!_view)
	{
	_view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];

	UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StatusGoogle.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
    UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
    bg.frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(40.0f, 0.0f, 395.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT); //450 = x on teh iPad
    
    CGRect frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(45.0f, 0.0f, 390.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT);
	searchField = [[UITextField alloc] initWithFrame:frame];
	searchField.placeholder = @"Search here!";
	searchField.textColor = [UIColor whiteColor];
	searchField.textAlignment = UITextAlignmentCenter;
	searchField.delegate = self;
	
	[_view addSubview:searchField];
	[_view addSubview:bg];
    [bg release];
	[searchField release];
	}

	return _view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[searchField resignFirstResponder];
	google = [searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	googleSearch = [NSString stringWithFormat:@"http://www.google.com/search?q=%@&ie=utf-8&oe=utf-8", google];
	NSURL *url = [NSURL URLWithString:googleSearch];
	searchField.text = nil;
	[[UIApplication sharedApplication] applicationOpenURL:url];
	
	return YES;
}

- (float)viewHeight
{
	return VIEW_HEIGHT;
}

@end
