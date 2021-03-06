ReturnValue = require 'nanocyte-component-return-value'
HttpFormatter = require '../src/http-formatter'

describe 'HttpFormatter', ->
  beforeEach ->
    @sut = new HttpFormatter

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
        expect(@sut.onEnvelope({@config})).to.deep.equal { headers: { '6': 'oi', '7': 'oioi', 'User-Agent': 'Octoblu' }, uri: 'http://taco.com',method: 'GET',followAllRedirects: true,qs: { q0: 'q1', q1: 'q2' },form: { t1: 'test', t2: 'test2' } }

    describe 'when called with only an URL for RSS feed', ->
       beforeEach ->
         @config =
          url: "http://taco.com"

       it 'should return the message', ->
         expect(@sut.onEnvelope({@config})).to.deep.equal { headers: { 'User-Agent': 'Octoblu' }, uri: 'http://taco.com',method: 'GET',followAllRedirects: true,qs: {} }
