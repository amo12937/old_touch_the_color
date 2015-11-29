"use strict"

module.exports = misc =
  randInt: (n) -> Math.floor Math.random() * n

  shuffle: (l) ->
    r = l[..]
    for item, i in r
      j = misc.randInt l.length
      r[i] = r[j]
      r[j] = item
    r

  createContainerAndPool: (n, m) ->
    sum = n + m
    l = misc.shuffle [0...sum]
    container: l[0...n]
    pool: l[n...sum]

