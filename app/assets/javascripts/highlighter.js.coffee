class Highway.Highlighter
  constructor: ->
    @container = $('#results')
    @form = $('#input form')
    @term = @form.find('#grep')

    @setListeners()

  setListeners: ->
    @term.keyup @matchTerm

  matchTerm: (evt) =>
    term = evt.target.value

    @resetMatch()
    @hideMatchInverse term
    @highlight term

  hideMatchInverse: (term) ->
    @container.find("p:not(:contains(#{term}))").hide()

  highlight: (term) ->
    @container.highlight(term)

  resetMatch: ->
    @container.find('p').show()
    @container.removeHighlight()
