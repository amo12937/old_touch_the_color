"use strict"

exports.create = (numOfHints, numOfTiles) ->
  misc = require "misc"
  SimplePublisher = require "amo.modules.simple_publisher"

  numOfPools = numOfTiles - numOfHints
  {container: hint, pool: pool} = misc.createContainerAndPool numOfHints, numOfPools

  publisher = SimplePublisher.create()

  register: publisher.register.bind publisher
  try: (n) -> hint[0] is n
  shift: ->
    i = misc.randInt numOfPools
    hint.push pool[i]
    pool[i] = hint.shift()
    publisher.publish "hint", @get()
  get: -> hint[..]
