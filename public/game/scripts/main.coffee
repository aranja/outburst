requestAnimFrame = (->
  window.requestAnimationFrame || 
  window.webkitRequestAnimationFrame || 
  window.mozRequestAnimationFrame    || 
  window.oRequestAnimationFrame      || 
  window.msRequestAnimationFrame     || 
  (callback, element) ->
    window.setTimeout(callback, 1000 / 60)
)()

socket = io.connect()
socket.on 'welcome', (data) ->
  console.log data
  
last = +new Date
animloop = ->
  now = +new Date
  delta = (now - last) / 1000.0
  last = now
  requestAnimFrame(animloop, world.container)
  
  world.update(delta)
  world.render()
    
document.addEventListener 'DOMContentLoaded', ->
  window.input = new Input()
  window.world = new World window.innerWidth - 10, window.innerHeight - 10
  animloop()
  

