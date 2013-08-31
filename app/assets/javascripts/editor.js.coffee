class Highway.Editor
  constructor: ->
    @form = Highway.Editor.form()
    @editor = ace.edit('editor')
    @editor = Highway.Editor.editor()
    @editor.getSession().setMode('ace/mode/ruby')
    @editor.setTheme('ace/theme/twilight')
    @editor.getSession().setTabSize(2)
    @editor.getSession().setUseSoftTabs(true)
    @editor.focus()
    @term = @form.find('#grep')

    @setListeners()
    @submitForm() if @editor.getValue().length > 0

  setListeners: ->
    @form.on 'submit', @submitForm
    @editor.on 'blur', @submitForm
    @editor.on 'change', @submitFormAfterDelay

  @editor: ->
    ace.edit('editor')

  @editorValue: ->
    @editor().getValue()

  @form: ->
    $('form#input')

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
