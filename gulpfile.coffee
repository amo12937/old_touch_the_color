"use strict"

do (gulp = require "gulp") ->
  path =
    src: (s) -> "src/#{s}"
    dev: (s) -> "dev/#{s}"
    dist: (s) -> "dist/#{s}"
    docs: (s) -> "docs/#{s}"

  # styles
  do (
    sass = require "gulp-sass"
    autoprefixer = require "gulp-autoprefixer"
  ) ->
    gulp.task "styles", ->
      gulp.src path.src "styles/main.scss"
      .pipe sass()
      .pipe autoprefixer()
      .pipe gulp.dest path.dev "styles/"
    return

  # style document
  do (
    styledocco = require "gulp-styledocco"
  ) ->
    gulp.task "styleguide", ->
      gulp.src path.src "styles/**/*.scss"
      .pipe(styledocco
        out: path.docs "styles"
        name: "styleguide"
        preprocessor: "sass"
      )

  # html
  do () ->
    gulp.task "htmls", ->
      gulp.src path.src "**/*.html"
      .pipe gulp.dest path.dev ""
    return

  return

