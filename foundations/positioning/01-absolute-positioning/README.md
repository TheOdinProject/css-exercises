# Absolute Positioning

This exercise will help you understand how to use CSS absolute positioning to place elements exactly where you want them within a container.

You need to position four elements using absolute positioning:
- Red box: top-left corner of the container
- Blue box: top-right corner of the container 
- Green box: bottom-left corner of the container
- Overlay: centered in the container, overlapping other elements

## Desired Outcome
![outcome](./desired-outcome.png)

### Self Check
- Are all boxes positioned correctly using absolute positioning?
- Is the container set as the positioning context (relative positioning)?
- Does the overlay appear on top of and centered in the container?
- Are the boxes positioned exactly at the corners as specified?

### Hints
- Remember that absolutely positioned elements are positioned relative to their nearest positioned ancestor
- The container needs to be the positioning context
- Use `top`, `right`, `bottom`, and `left` properties to specify exact positions
- The overlay should be centered both horizontally and vertically
