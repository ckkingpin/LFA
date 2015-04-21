jQuery ->
  if  $('.select-categories').val()
    categories = $('.select-categories').val()
    $('.select-categories').val(categories.replace(/\ /g,','))
    $.ajax
      url: '/categories/categories_names?category_ids=' + encodeURIComponent($('.select-categories').val())
      type: 'GET'
      success: (res) ->
        $('.select-categories')[0].selectize.renderCache = {}
        res.res.forEach (item) ->
          $('.selectize-control').find("div[data-value=#{item.id}]").find('span.name').text(item.name)
          $('.select-categories')[0].selectize.options[item.id] = {id: item.id, name: item.name}
        return

  $('.select-categories').selectize
    create: true
    persist: true
    maxItems: null
    valueField: 'id'
    labelField: 'name'
    searchField: [ 'name' ]
    plugins: [
      'remove_button'
      'drag_drop'
      'restore_on_backspace'
    ]
    options: []
    render:
      item: (item, escape) ->
        '<div>' + (if item.name then '<span class="name">' + escape(item.name) + '</span>' else '') + '</div>'
      option: (item, escape) ->
        label = item.name or item.name
        '<div>' + '<span><strong>' + escape(label) + '</strong></span>' + '</div>'
    create: (input, callback) ->
      $.ajax
        url: '/categories/add_category?name=' + encodeURIComponent(input)
        type: 'GET'
        error: ->
          callback()
          return
        success: (res) ->
          callback ({
            id: res.id
            name: res.name
          })
          return
      return
    load: (query, callback) ->
      if !query.length
        return callback()
      $.ajax
        url: '/categories/autocomplete?q=' + encodeURIComponent(query)
        type: 'GET'
        error: ->
          callback()
          return
        success: (res) ->
          callback res
          return
      return
  return
