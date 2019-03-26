// Code created by hamzasood. See gist.github.com/hamzasood

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// Hook with ObjC runtime functions
%config(generator=internal)

%hook UIDevice

/*
    Needed so that -[UITraitCollection forceTouchCapability] returns true.
    While this isn't needed for the actual 3D Touch interactions, most apps won't register for previewing unless this returns true.
*/
- (BOOL)_supportsForceTouch {
    return YES;
}

%end


%hook UIGestureRecognizer


- (void)setAllowedTouchTypes:(NSArray<NSNumber *> *)allowedTouchTypes {
    if (![allowedTouchTypes containsObject:@(UITouchTypeStylus)]) {
        allowedTouchTypes = [allowedTouchTypes arrayByAddingObject:@(UITouchTypeStylus)];
    }
    %orig(allowedTouchTypes);
}

%end
