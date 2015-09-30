ReturnValue = require 'nanocyte-component-return-value'
HttpNode = require '../src/http-node'

describe 'HttpNode', ->
  beforeEach ->
    @sut = new HttpNode

  it 'should exist', ->
    expect(@sut).to.be.an.instanceOf ReturnValue

  describe '->onEnvelope', ->
    describe 'when called with an envelope', ->
      beforeEach ->
        @config =
         url: "http://taco.com"
         bodyValues: ['test', 'test2']
         method: 'GET'
         queryValues: ['q1', 'q2']
         headerValues: ['oi', 'oioi']
         headerKeys: ['6', '7']
         bodyEncoding: 'form'
         bodyKeys: ['t1', 't2']
         queryKeys: ['q0', 'q1']

      it 'should return the message', ->
        console.log (@sut.onEnvelope({@config}))
        expect(@sut.onEnvelope({@config})).to.deep.equal { headers: { '6': 'oi', '7': 'oioi', 'User-Agent': 'Octoblu' },uri: 'http://taco.com',method: 'GET',followAllRedirects: true,qs: { q0: 'q1', q1: 'q2' },form: { t1: 'test', t2: 'test2' } }
