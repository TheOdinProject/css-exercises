# Layering with Z-Index

This exercise teaches you how to control the layering of absolutely positioned elements using the `z-index` property.

You need to position four overlapping elements and control their stacking order:
- Background layer: positioned behind all others
- Middle layer: positioned above background but below foreground
- Foreground layer: positioned above middle but below top
- Top layer: positioned on top of all others

The layers should overlap in a cascading pattern from top-left to bottom-right.

## Desired Outcome
![outcome](./desired-outcome.png)

### Self Check
- Are all elements absolutely positioned within the container?
- Do the elements overlap in the correct stacking order?
- Is the container set as the positioning context?
- Are the z-index values used correctly to control layering?

### Hints
- Use `position: relative` on the container to establish positioning context
- Use `position: absolute` on all layer elements
- Use `z-index` to control which elements appear on top
- Higher z-index values appear above lower ones
- Elements positioned later in the HTML appear above earlier ones by default
