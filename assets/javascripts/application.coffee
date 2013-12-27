#
#= require 'more'
#= require 'jquery-1.10.2.min'
#

console.log "hello application!"

$ ->
  $('#btn').bind 'click', () ->
    beacon "button_click", { id: "btn" }

  $('#link').bind 'click', (e) ->
    e.preventDefault()
    beacon "link_click", { id: "link" }
    location.href = $(this).attr('href')

