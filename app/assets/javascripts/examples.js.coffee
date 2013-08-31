class Highway.Examples
  constructor: ->
    @shareButton = $ '#share_button'
    @shareForm = @shareButton.parents('form:first')

    @setListeners()

  setListeners: ->
    @shareButton.on 'click', @shareExample

  shareExample: (evt) =>
    evt.preventDefault()
    routeInput = $('<input>').attr(type: 'hidden', name: 'example[route]', value: @formRoute())
    grepInput = $('<input>').attr(type: 'hidden', name: 'example[grep]', value: @formGrep())
    @shareForm.append routeInput
    @shareForm.append grepInput
    @shareForm.submit()

  formRoute: ->
    Highway.Editor.editorValue()

  formGrep: ->
    Highway.Editor.form().find('#grep').val()
