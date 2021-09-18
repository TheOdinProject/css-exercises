# A Basic Header

Use flexbox rules to create this very common webpage header style. The benefit to using flex here is that everything should be _flexible_. Check out the two screenshots below to get an idea for how it should scale with your screen. Besides flex rules, you'll also want to add some rules for margin and padding. (hint: `ul`s have some default margin/padding that you will need to deal with)

## Desired Outcome

narrow:
![narrow](./desired-outcome-narrow.png)

wide: 
![wide](./desired-outcome-wide.png)

### Self Check
- There is space between all items and the edge of the header (specific px amount doesn't matter here)
- Logo is centered vertically and horizontally.
- list-items are horizontal, and are centered vertically inside the header
- left-links and right-links are pushed all the way to the left and right, and stay at the edge of the header when the page is resized.
- This exercise does not use floats, inline-block, or absolute positioning.

This exercise took me some time, my initial approach was to inspect the html file, there I noticed that two classes where created "Left link and right link" and those were not being used in the CSS file, so I created them and attempted to apply properties, that just ended up confusing me a lot, and ofcourse, after getting frustrated, I ended up in discord help.  there @tatianatothe#5216 explained that those classes where more for visual interpretation, and she help me with my frustration.  Thanks @tatianatothe#5216.   The Odin Community is awsome.