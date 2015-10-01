ReturnValue = require 'nanocyte-component-return-value'
_ = require 'lodash'

class HttpFormatter extends ReturnValue
  onEnvelope: (envelope) =>
    { config } = envelope
    { url , bodyValues , method, queryValues , headerValues, headerKeys , bodyEncoding , bodyKeys , queryKeys} = config
    encodingKey = bodyEncoding
    encodingKey ?= 'json'

    params =
      headers:
        'User-Agent': 'Octoblu'
      uri: url
      method: method || 'GET'
      followAllRedirects: true
      qs: {}

    _.each queryKeys, (key, index) ->
      value = queryValues[index]
      if (!_.isUndefined(value) && !_.isNull(value))
        params.qs[key] = value

     _.each bodyKeys, (key, index) ->
       bodyValues = bodyValues || []
       params[encodingKey] = params[encodingKey] || {}
       params[encodingKey][key] = bodyValues[index]

    _.each headerKeys, (key, index) ->
      value = headerValues[index]
      if (!_.isUndefined(value) && !_.isNull(value))
        params.headers[key] = value

    return params

module.exports = HttpFormatter
