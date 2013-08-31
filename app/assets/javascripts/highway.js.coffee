class @Highway
  constructor: ->
    new Highway.Editor()
    new Highway.Highlighter()
    new Highway.Examples()

$ ->
  new Highway()
