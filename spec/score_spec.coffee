"use strict"

chai = require "chai"
expect = chai.expect
sinon = require "sinon"
sinonChai = require "sinon-chai"
chai.use sinonChai

Score = require "score"
ObservableValue = require "amo.modules.observable_value"
misc = require "misc"

describe "Score は", ->
  it "create プロパティを持っている", ->
    expect(Score).to.have.property "create"

  describe "そのインスタンスは", ->
    s = null
    high = 5
    beforeEach ->
      s = Score.create high

    ["high", "score", "increment", "reset"].forEach (prop) ->
      it "#{prop} プロパティを持つ", ->
        expect(s).to.have.property prop

    describe "increment プロパティは", ->
      it "score に 1 を加算する", ->
        expect(s.score).to.equal 0
        s.increment()
        expect(s.score).to.equal 1

      it "数字を渡すとその分だけ score に加算する", ->
        expect(s.score).to.equal 0
        s.increment 5
        expect(s.score).to.equal 5

      it "score が high を超えた場合は high も更新される", ->
        s.increment high - 1
        expect(s.high).to.equal high
        s.increment()
        expect(s.high).to.equal high
        s.increment()
        expect(s.high).to.equal high + 1

    describe "reset プロパティは", ->
      it "score の値を 0 にする", ->
        s.increment 5
        expect(s.score).to.equal 5
        s.reset()
        expect(s.score).to.equal 0

      it "high の値は変えない", ->
        h = 2 * high
        s.increment h
        expect(s.high).to.equal h
        s.reset()
        expect(s.high).to.equal h

