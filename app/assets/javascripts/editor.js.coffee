class Highway.Editor
  constructor: ->
    @form = $('#input form')
    @editor = ace.edit('editor')
    @editor.getSession().setMode('ace/mode/ruby')
    @editor.setTheme('ace/theme/twilight')
    @editor.getSession().setTabSize(2)
    @editor.getSession().setUseSoftTabs(true)
    @term = @form.find('#grep')

    @setListeners()

  setListeners: ->
    @form.on 'submit', @submitForm
    @editor.on 'blur', @submitForm
    @editor.on 'change', @submitFormAfterDelay

  submitForm: =>
    $.ajax
      method: 'post'
      dataType: 'text'
      url: @form.data('url')
      data:
        route: @editor.getValue()
      success: @displayResults
      error: @displayError

  displayResults: (data, status, xhr) =>
    $('#results').html('')
    $('#error').slideUp()
    data.split(/\n/).forEach (line) ->
      pTag = $('<p></p>').html(line)
      $('#results').append(pTag)

    @term.trigger('keyup')

  submitFormAfterDelay: =>
    clearTimeout(@timeout)
    @timeout = setTimeout(@submitForm, 500)

  displayError: (xhr, status, error) =>
    $('#error').html(xhr.responseText).slideDown()
