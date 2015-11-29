"use strict"

chai = require "chai"
expect = chai.expect
sinon = require "sinon"
sinonChai = require "sinon-chai"
chai.use sinonChai

ItemContainer = require "item_container"
misc = require "misc"

describe "ItemContainer は", ->
  it "create プロパティを持っている", ->
    expect(ItemContainer).to.have.property "create"

  describe "その instance は", ->
    numOfTiles = 9
    numOfPools = 9
    itemContainer = cp = mock = null
    beforeEach ->
      cp = misc.createContainerAndPool numOfTiles, numOfPools
      mock = sinon.mock misc
      mock.expects("createContainerAndPool").once().returns cp

      itemContainer = ItemContainer.create numOfTiles, numOfPools

    afterEach ->
      mock.verify()

    ["register", "select", "get"].forEach (prop) ->
      it "#{prop} プロパティを持つ", ->
        expect(itemContainer).to.have.property prop

    describe "select プロパティは", ->
      it "選択した番号の値が pool のどれかと入れ替わる", ->
        old =
          container: cp.container[..]
          pool: cp.pool[..]

        n = misc.randInt numOfTiles
        itemContainer.select n
        expect(cp.pool).to.include old.container[n]
        expect(old.pool).to.include cp.container[n]

      it "item が変更されたことを通知する", (done) ->
        n = misc.randInt numOfTiles
        oldContainer = cp.container[..]
        itemContainer.register "item", (i, oldVal, newVal) ->
          expect(i).to.equal n
          expect(oldVal).to.equal oldContainer[n]
          expect(newVal).to.equal cp.container[n]
          done()

        itemContainer.select n

      it "選択した番号が範囲外の場合何も怒らない", ->
        counter = 0
        itemContainer.register "item", -> counter++
        itemContainer.select -1
        itemContainer.select numOfTiles
        expect(counter).to.equal 0

    describe "get プロパティは", ->
      it "item のリストを返す", ->
        expect(itemContainer.get()).not.to.equal cp.container
        expect(itemContainer.get()).to.eql cp.container

    describe "register プロパティは", ->
      it "listener を登録する", (done) ->
        itemContainer.register "item", -> done()
        itemContainer.select misc.randInt numOfTiles




