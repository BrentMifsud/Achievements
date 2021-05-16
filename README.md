# Achievements
Achievements Screen Mockup

## Assumptions
- Achievements will have unique names
- The whitespace padding around some of the imags is intentional (see known issues below)

## Known Issues

### Padding around some achievements
Some of the medals appear slightly smaller than the others. This is due to the fact that the PDFs have padding surrounding the image. Normally, I would let the designer know about this so they could correct this issue. 
An alternative solution would be to crop the image myself
A third solution would be to use aspect fill content mode and ensure that the aspect ratio of the image is the exact size so that the white space is hidden (this is an error prone solution. Much better to crop it myself or get the designer to correct the issue.)

### Runtime Optimization Warning
I have added shadows to the achievments to match the designs. This is an expensive thing to do programatically. 
And xcode provides a runtime warning for it.
Apple recommends adding the shadows as part of the images themselves for best performance.
For such a small array of objects, it doesnt make a big enough difference to warrant addressing right now.
