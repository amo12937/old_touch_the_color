"use strict"

chai = require "chai"
expect = chai.expect
sinon = require "sinon"
sinonChai = require "sinon-chai"
chai.use sinonChai

Hint = require "hint"
misc = require "misc"

describe "Hint は", ->
  it "create プロパティを持っている", ->
    expect(Hint).to.have.property "create"

  describe "その instance は", ->
    numOfHints = 4
    numOfTiles = 9
    hint = cp = mock = null
    beforeEach ->
      cp = misc.createContainerAndPool numOfHints, numOfTiles - numOfHints
      mock = sinon.mock misc
      mock.expects("createContainerAndPool").once().returns cp
      
      hint = Hint.create numOfHints, numOfTiles

    afterEach ->
      mock.verify()

    ["register", "try", "shift", "get"].forEach (prop) ->
      it "#{prop} プロパティを持つ", ->
        expect(hint).to.have.property prop

    describe "try プロパティは", ->
      it "第1引数に hint[0] を渡すと true を返す", ->
        expect(hint.try cp.container[0]).to.be.true

      it "第1引数に hint[0] 以外を渡すと false を返す", ->
        expect(hint.try cp.container[1]).to.be.false


    describe "shift プロパティは", ->
      it "hint の先頭を取り出し、pool のどれかを hint の最後に加える", ->
        old =
          container: cp.container[..]
          pool: cp.pool[..]

        hint.shift()
        expect(hint.try old.container[1]).to.be.true
        expect(old.pool).to.include cp.container[numOfHints - 1]
        expect(cp.pool).to.include old.container[0]
        
      it "hint が変更されたことを通知する", (done) ->
        hint.register "hint", (actual) ->
          expect(actual).not.to.equal cp.container
          expect(actual).to.eql cp.container
          done()

        hint.shift()

    describe "get プロパティは", ->
      it "hint のリストを返す", ->
        expect(hint.get()).not.to.equal cp.container
        expect(hint.get()).to.eql cp.container

    describe "register プロパティは", ->
      it "リスナーを登録する", (done) ->
        hint.register "hint", -> done()
        hint.shift()

