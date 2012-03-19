#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 25.0f

@interface UIApplication (sg_SpringBoard)
- (void)applicationOpenURL:(id)url;
- (int)_frontMostAppOrientation;
@end

@interface UIDevice (sg_UIDevice_iPad)
- (BOOL)isWildcat;
@end

@interface StatusGoogleController : NSObject <BBWeeAppController, UITextFieldDelegate> {
	UIView *_view;
	UIImageView *bg;
}

@property (nonatomic, retain) UIView *view;
@end

static NSURL *SGURL(NSString *url) {
	NSArray *arr = [NSArray arrayWithObjects:@"http://",@"https://",@"www.",@".com",@".net",@".org",@".us",@".me",@".it",@".uk",@".de",nil];
	for (NSString *k in arr) {
		if ([url rangeOfString:k].location != NSNotFound) {
			NSURL *r = [NSURL URLWithString:url];
			if (![[r scheme] length]) r = [NSURL URLWithString:[@"http://" stringByAppendingString:url]];
			return r;
		}
	}
	
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/search?q=%@&ie=utf-8&oe=utf-8", url]];
}

@implementation StatusGoogleController
@synthesize view = _view;

- (void)loadPlaceholderView {
	_view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {316.0f, VIEW_HEIGHT}}];
	_view.autoresizingMask = UIViewAutoresizingFlexibleWidth;

	UIImage *bgImg = [UIImage imageWithContentsOfFile:@"/Library/WeeLoader/Plugins/StatusGoogle.bundle/WeeAppBackground.png"];
	UIImage *stretchableBgImg = [bgImg stretchableImageWithLeftCapWidth:floorf(bgImg.size.width / 2.f) topCapHeight:floorf(bgImg.size.height / 2.f)];
	UIImageView *_backgroundView = [[[UIImageView alloc] initWithImage:stretchableBgImg] autorelease];
	_backgroundView.frame = CGRectInset(_view.bounds, 2.0f, 0.0f);
	_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[_view addSubview:_backgroundView];
}

- (void)loadFullView {
	UITextField *searchField = [[[UITextField alloc] initWithFrame:CGRectInset(_view.bounds, 4.f, 0.f)] autorelease];
	searchField.placeholder = @"Search here!";
	searchField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	searchField.textColor = [UIColor whiteColor];
	searchField.textAlignment = UITextAlignmentCenter;
	searchField.delegate = self;
	
	[_view addSubview:searchField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	if (![textField.text isEqualToString:@""]) {
		NSString *google = [textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		[[UIApplication sharedApplication] applicationOpenURL:SGURL(google)];
	}
	
	return YES;
}

- (void)unloadView {
	[_view release];
	_view = nil;
}

- (float)viewHeight {
	return VIEW_HEIGHT;
}

- (void)dealloc {
	[_view release];
	[super dealloc];
}
@end
