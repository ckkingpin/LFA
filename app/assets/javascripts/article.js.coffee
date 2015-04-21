jQuery ->
  $('#article_content').hide()

  if $('#editor-preview').length
    editor_preview = ace.edit('editor-preview')
    set_editor_properties(editor_preview)
    editor_preview.setReadOnly(true);
    document.getElementById('editor-preview').style.fontSize = '16px';

  if $('#editor').length
    editor = ace.edit("editor");
    set_editor_properties(editor)
    document.getElementById('editor').style.fontSize = '16px';

    editor.getSession().on('change', (e) ->
      $('textarea#article_content').val(editor.getValue())
    );

  $('#resizable').resizable resize: (event, ui) ->
    editor.resize()
    return

  $(document).on('click', '.submit-article', (e) ->
    $('textarea#article_content').val(editor.getValue())
  )

set_editor_properties = (element) ->
  element.setValue($('#article_content').val())
  element.setTheme("ace/theme/chrome");
  element.getSession().setTabSize(2);
  element.getSession().setMode("ace/mode/html");
