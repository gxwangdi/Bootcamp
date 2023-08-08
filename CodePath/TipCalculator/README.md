README for TipCalculator
# Pre-work - TipCalculator

TipCalculator is a tip calculator application for iOS.

Submitted by: Di Wang

Time spent: 10 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
Extend the color, foreground and background; experiment static util class; Theme switching is in plan but not sure I have time to do it at this time.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/gxwangdi/CodePath/blob/master/TipCalculator/TipCalculator.gif' title='Video Walkthrough' width='300' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** Since I have android dev background, iOS development seems pretty similar to android dev. A lot of similar concepts and operations, at least in UI. And Swift is definitely more flexible than java, have not tried kotlin though. outlets can be treated as UI component binding, like an representation, a model of the widget in code, or the return value of View.findViewById() or View.findViewByTag() if they have android dev exp. actions is like the event listener, or the observer if they are more familiar with observer pattern. And yes the implementation is pretty similar to that in android underneath, utilizing a descriptive structure language to describe the components, and the system will  parse them as some objects.     

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** In closure A make something, constant or variable, as a strong reference to closure B, and in Closure B make soemthing as  a strong reference to closure A, that will build a strong reference cycle.   


## License

    Copyright [2017] [@Di Wang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
