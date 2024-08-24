; This program is free software; you can redistribute it and/or modify

; it under the terms of the GNU General Public License as published by

; the Free Software Foundation; either version 2 of the License, or

; (at your option) any later version.

;

; This program is distributed in the hope that it will be useful,

; but WITHOUT ANY WARRANTY
; without even the implied warranty of

; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

; GNU General Public License for more details.



(define (script-fu-photocopy-stack theImage theMaskRadius theSharpness thePctBlack thePctWhite)
  ;For each layer of an image
  (let*
    (
      (white-layer 0)
      (theDefMaskRadius 50.0)
      (theDefSharpness 0.5)
      (theDefPctBlack 1.0)
      (theDefPctWhite 0.2)
    )
    (gimp-image-undo-group-start theImage)
    (map 
      (lambda (aLayer)
        (gimp-layer-add-alpha aLayer)
        ;photocopy
        (plug-in-photocopy 1 theImage aLayer theMaskRadius theSharpness thePctBlack thePctWhite )
        ;set white to alpha
        (plug-in-colortoalpha 1 theImage aLayer '(255 255 255))
      )
      (vector->list 
        (cadr 
          (gimp-image-get-layers theImage)
        )
      )
    )
    ;Then add a white layer as a bottom layer.
    (set! white-layer (car (gimp-layer-new theImage 100 100 0 "White Background" 100 0)))
    (gimp-image-add-layer theImage white-layer (+ 1 (car (gimp-image-get-layers theImage) ) ) )
    (gimp-layer-resize-to-image-size white-layer)
    (gimp-drawable-fill white-layer 2)
    (gimp-image-undo-group-end theImage)
    (gimp-displays-flush)
  )
)


(script-fu-register
    "script-fu-photocopy-stack"                 ;func name
    "Photocopy and stack..."                       ;menu label
    "Creates something that looks like a drawn image from a focus stacked series.\
     Takes a focus stack series opened as layers, \
     on each layer it applies the photocopy plugin,\
     makes white transparent, and puts this all on \
     a white background."      ;description
    "DAVE Robson"                               ;author
    "copyright 2012 DAVE Robson;"               ;copyright notice
    "March 31st, 2012"                          ;date created
    "RGB"                                       ;image type that the script works on
    SF-IMAGE    "Image"    0
    SF-ADJUSTMENT "Mask Radius"     '(50.0 3.00 50.00 0.01 5.0 2 0)
    SF-ADJUSTMENT "Sharpness"       '(0.5  0.000 1.000 0.001 0.1 3 0)
    SF-ADJUSTMENT "Percent Black"   '(1.0  0.000 1.000 0.001 0.1 3 0)
    SF-ADJUSTMENT "PercentWhite"    '(0.2  0.000 1.000 0.001 0.1 3 0)
  )
  (script-fu-menu-register "script-fu-photocopy-stack" "<Image>/Filters/Artistic")