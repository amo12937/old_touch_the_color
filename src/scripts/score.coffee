"use strict"

exports.create = (high) ->
  ObservableValue = require "amo.modules.observable_value"

  ov = ObservableValue.create
    high: high
    score: 0

  ov.increment = (n = 1) ->
    @score += n
    if @high < @score
      @high = @score
  ov.reset = ->
    @score = 0

  return ov

