# script-fu-photocopy-stack

"Photocopy and stack..."

Looking through books on microscopy subjects, I was always interested in the 
drawings and woodcuts featured in them. I learned about how they were made, but 
was not particularly skillful in drawing them by hand. I was doing a lot of 
image stacking to get more image depth, and I realized these stacked images 
could be made to look like a drawing with some clever editing.

`script-fu-photocopy-stack` is a GIMP Script-Fu script that creates something that looks 
like a drawn image from a focus stacked series. It takes a focus stack series 
opened as layers, on each layer it applies the photocopy plugin, makes white 
transparent, and puts this all on a white background.

## Instructions

1. Open your set of focus stacked images with "Open as Layers...".
    From my experience, semitransparent subjects with a white/light background work best for the effect this is intended for. I've had the best experience with things like diatoms, radiolarians, and desmids.
2. Go to "Filters->Artistic->Photocopy and stack..."
3. Adjust the photocopy settings as appropriate, and hit "Ok". 

You can undo this script's operations.