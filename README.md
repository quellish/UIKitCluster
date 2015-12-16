#UIKitCluster

Demonstrates a Class Cluster for a UIView

Also shows views defined in nib/xib files being loaded from a storyboard.

###UIView Class Cluster

This example implements a "class cluster" for a UIView subclass. `GenericView` is an abstract interface, "SpecificView" is a concrete implementation of that interface. 

While this example is demonstrating a class cluster for a UIView the same methods can be used to do the same for UIViewControllers and other UIKit classes.

### IBInspectable, IB_DESIGNABLE

The example views use IB_DESIGNABLE and IBInspectable for preview and editing in the storyboard using the views.

###Loading Xib-based Views from Storyboards

Nibs can contain references to objects in other nibs through "External Object" references. This makes it very easy to reuse components and share them across nibs.

When a storyboard is loaded it is unarchived using a system-supplied object implementing NSUnarchiver. This decodes all of the objects referenced in the storyboard to build the in-memory object graph. Storyboards do not have external object references like xibs do, though in Xcode 7 it became possible to have a reference to an external storyboard.

It is very easy to change the default behavior to load objects from external archives. By customizing what happens when an object is decoded we can add the ability to load and initialize from external archives to extend the default behavior. This allows an application to use views that are described in xib files inside storyboards.

The `NSCoding` and `NSCoderMethods` protocols describes the methods that are used for encoding and decoding objects. `initWithCoder:`, `awakeAfterUsingCoder:`, `replacementObjectForCoder:` and `classForCoder:` are all opportunities to change the default behavior when an object is being decoded. 

In this example we are customizing the implementation of `initWithCoder:` to load a specific xib file and it's views. The xib itself has a specific structure that makes it easier to create a consistent set of views and constraints wether it was instantiated through `initWithFrame:`, `prepareForInterfaceBuilder` or `initWithCoder:`. The `initializeSubviews` method uses an instance variable as a dispatch_once token protected by a memory barrier. This allows the code inside `initializeSubviews` to be executed only once _per instance_. This is not necessary for many applications. Different approaches may be useful for your application's specfic needs.

