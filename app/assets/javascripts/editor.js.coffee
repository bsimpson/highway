class Highway.Editor
  constructor: ->
    @form = $('#input form')
    @editor = ace.edit('editor')
    @editor.getSession().setMode('ace/mode/ruby')
    @editor.setTheme('ace/theme/twilight')

    @setListeners()

  setListeners: ->
    @form.on 'submit', @submitForm

  submitForm: (evt) =>
    evt.preventDefault()
    $.ajax
      method: 'post'
      dataType: 'text'
      url: @form.data('url')
      data:
        route: @editor.getValue()
      success: @displayResults

  displayResults: (data, status, xhr) ->
    $('#results').html('')
    data.split(/\n/).forEach (line) ->
      pTag = $('<p></p>').html(line)
      $('#results').append(pTag)
