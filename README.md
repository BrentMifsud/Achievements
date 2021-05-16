# Achievements
Achievements Screen Mockup

## Assumptions
- Achievements will have unique names

## Known Issues

### Padding around some achievements
Some of the medals appear slightly smaller than the others. This is due to the fact that the PDFs have padding surrounding the image. Normally, I would let the designer know about this so they could correct this issue. 
An alternative solution would be to crop the image myself
A third solution would be to use aspect fill content mode and ensure that the aspect ratio of the image is the exact size so that the white space is hidden (this is an error prone solution. Much better to crop it myself or get the designer to correct the issue.)

### Delay on start when launching via simulator.
- Does not happen on real devices. Only in the simulator.
- When running the simulator with the instruments app attached, the delay is gone, and there are no operations blocking the main thread.
- I have been having quite a few issues with simulator performance the past few months. I am assuming its related to that.
- Please let me know if you also experience this issue.

### Runtime Optimization Warning
- I have added shadows to the achievments to match the designs. When scrolling through the list of medals you will see a blue runtime warning.
- According to Apple, shadows are expensive to render at runtime, and if possible, they should be added to the image asset itself.
- For such a small array of objects, it doesnt make a big enough difference to warrant addressing right now. And since grids/lists are lazily loaded, there will only ever be a few on screen at a time.s
