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

  # html
  do () ->
    gulp.task "htmls", ->
      gulp.src path.src "**/*.html"
      .pipe gulp.dest path.dev ""
    return

  return

