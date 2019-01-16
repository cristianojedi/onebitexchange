$(document).ready ->

  $body = $("body")

  $('#amount').keyup ->
      convert()

  convert = ->

    if $('#amount').val() != ''

      amount = $('#amount').val()
      blockdisplay true

      $.ajax '/convert',
        type: 'GET'
        dataType: 'json'
        data: {
                source_currency: $("#source_currency").val(),
                target_currency: $("#target_currency").val(),
                amount: amount
              }
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, text, jqXHR) ->
          $('#result').val(data.value)
          blockdisplay false
      return false
    else
      $('#result').val('')
      blockdisplay false

  blockdisplay = (block) ->
    if block
      $body.addClass("loading")
      $("input").prop('disabled', true)
    else
      $body.removeClass("loading")
      $("input").prop('disabled', false)

  $('#change').click ->
    source_currency = $('#source_currency').val()
    target_currency = $('#target_currency').val()

    $('#source_currency').val(target_currency)
    $('#target_currency').val(source_currency)

    convert()
