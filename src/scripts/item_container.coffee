"use strict"

exports.create = (numOfTiles, numOfPools) ->
  misc = require "misc"
  SimplePublisher = require "amo.modules.simple_publisher"

  {container, pool} = misc.createContainerAndPool numOfTiles, numOfPools
  publisher = SimplePublisher.create()

  register: publisher.register.bind publisher
  select: (n) ->
    return unless 0 <= n < numOfTiles
    i = misc.randInt numOfPools
    [container[n], pool[i]] = [pool[i], container[n]]
    publisher.publish "item", n, pool[i], container[n]
  get: -> container[..]

