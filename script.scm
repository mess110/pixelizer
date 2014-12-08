; for each file in the current directory
(let* ( (file's (cadr (file-glob "*.xcf" 1))) (filename "") (image 0) (layer 0) )
  (while (pair? file's)
    ; merge layers
    (set! image (car (gimp-file-load RUN-NONINTERACTIVE (car file's) (car file's))))
    (set! layer (car (gimp-image-merge-visible-layers image CLIP-TO-IMAGE)))
    (set! filename (string-append (substring (car file's) 0 (- (string-length (car file's)) 4)) ".png"))

    ; get original height/width
    (let* ((pixel-size 10))
    (let* ((new-scale 20))
    (let* ((original-height (car (gimp-image-height image))))
    (let* ((original-width (car (gimp-image-width image))))

      ; apply effects
      (plug-in-pixelize2 RUN-NONINTERACTIVE image layer pixel-size pixel-size)
      (gimp-image-scale-full image (/ (* new-scale original-width) 100) (/ ( * new-scale original-height) 100) INTERPOLATION-CUBIC)

      ; save
      (gimp-file-save RUN-NONINTERACTIVE image layer filename filename)
      (gimp-image-delete image)
      (set! file's (cdr file's))
      ))))
  )
  (gimp-quit 0)
)
