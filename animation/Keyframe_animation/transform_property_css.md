# Transform Property CSS
Transform property of css lets you Rotate, Translate, Scale and apply many different transformations on HTML ekements.

Syntax : `transform: function();`
## Different functions :-
- `transform: matrix();`
matrix(a, b, c, d, tx, ty);
matrix(scaleX(), skewY(), skewX(), scaleY(), translateX(), translateY());
where a, b, c, d define linear transformations and tx, ty descrie the transformation to be dine.
- `transform: perspective();`
Example : transform: perspective(123px);
Here we can change the perspective of direction of viewing the HTML element.
- `transform: rotate();`
Example : rotate(12deg);
As the name suggests Rotate function will turn our element accoringly. Here we have multiple similar functions, rotate3d(), rotateX(0, rotateY(), rotateZ().
- `transform: translate();`
Example : translate(20px, 22%)
We can shift elements from their defined position to the new position in any direction using translate functions. Here we have multiple similar functions, translate3d(), translateX(), translateY(), translateZ().
- `transform: scale();`
Example : scale(2);
As the name suggests scale function changes the dimentions of the element change can be positive or negative. Similar functions, scaleX(0), scaleY(), scaleZ(), scale3d().
- `transform: skew();`
Example : skew(12deg, 30deg);
skew function is takes either one or two values deciding amount of skewing in X adn Y direction. Similar functions, skewX(), skewY().