# TMFloatingButton
With this simple project you can add and design your material round button like in android apps.

![](https://raw.github.com/IhorShevchuk/TMFloatingButton/master/FloatingButton/screen.png)

## Installation
1) Add Folder `TMFloatingButton` to project

2) Import file `TMFloatingButton.h` to files where buttons will be shown

## Usage
1) In some method (ex:`viewDidLoad`) init `TMFloatingButton` object and add it to view where it should appear using next code:
```objectivec
  TMFloatingButton *floatingModeEditButton = [[TMFloatingButton alloc] initWithSuperView: self.navigationController.view];
```
2) Apply one of predifined styles using next code:
```objectivec
 [TMFloatingButton addModeEditStyleToButton:floatingModeEditButton];
```
3) Add `target` and `selector` using next code:
```objectivec
 [floatingModeEditButton addTarget:self action:@selector(modeEditAction) forControlEvents:UIControlEventTouchUpInside];
```


### Design own button
For now you can use next styles
- _Favorite Style_        - Star button

![](https://raw.github.com/IhorShevchuk/TMFloatingButton/master/FloatingButton/favorites1.png) ![](https://raw.github.com/IhorShevchuk/TMFloatingButton/master/FloatingButton/favorites2.png)

- _Mode Edit Style_  -     Red button with pen

![](https://raw.github.com/IhorShevchuk/TMFloatingButton/master/FloatingButton/modeEdit.png)

- _Message Style_  -  New message button

![](https://raw.github.com/IhorShevchuk/TMFloatingButton/master/FloatingButton/newMessage.png)
####How can I design my own?
You can use one of next methods to create your own style 
- To add state with text use next code:
```objectivec
    [customTextButton addStateWithText:@"Custom text" withAttributes:textAttributesDictionary andBackgroundColor:bgColor forName:@"CustomTextState" applyRightNow:YES];
```
![](https://raw.github.com/IhorShevchuk/TMFloatingButton/master/FloatingButton/customText.png)
- To add state with icon use next code
```objectivec
    [customIconButton addStateWithIcon:[UIImage imageNamed:@"icon-image"] andBackgroundColor:bgColor forName:@"CustomIconState" applyRightNow:NO];
```
- To add state with icon and text use next code
```objectivec
   [customIconAndTextButton addStateWithIcon:[UIImage imageNamed:@"icon-image"] andText:@"Custom text" withAttributestextAttributesDictionary andBackgroundColor:bgColor forName:@"CustomTextAndIconState" applyRightNow:NO];
```
- Or you can design your own UIView and set using next code
```objectivec
    [customViewButton addStateWithView:customView andBackgroundColor:bgColor forName:@"CustomViewState" applyRightNow:YES];
```
#####About ApplyRightNow and TextAttributesDictionary parameters
- `BOOL` parameter ApplyRightNow is using when you need set this state immediatly after adding state
- TextAttributesDictionary is `NSDictionary` of text attributes (ex:`NSFontAttributeName`,`NSForegroundColorAttributeName`), for now you can apply only `NSFontAttributeName`,`NSForegroundColorAttributeName` in next version we add more text attributes
  
####Why I need to create `TMFloatingButtonState`s?
Sometimes button can change states during the app runing. 
Example add to favorites button that indicates if object(artilce,words,tags) added to favorites or not. And you can easy set  this states with initing and after that just change states in different places in code
  ```objectivec
 [button setButtonState:@"myState2"];
  ```

#####How can I show `UIActivityIndicatorView` while button's state is changing?
You can simply show `UIActivityIndicatorView` using this code:
Notice that all methods are called in different thread

 ```objectivec
     [floatingButton animateActivityIndicatorStart:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        [floatingButton setButtonState:@"saved"];
        [floatingButton animateActivityIndicatorStart:NO];
         });
  ```
See example code for more details

## License
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
