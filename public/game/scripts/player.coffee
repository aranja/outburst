class PlayerUnit extends THREE.Object3D
  constructor: (state) ->
    super()
    @splitModel = new SplitPlayerModel()
    @addChild @splitModel
    @id = state.id
    @addState(state)

  addState: (state) ->
    @position.x = state.x
    @position.y = state.y
    @setNick state.nick if state.nick != @nicktext
    if state.shots
      for shot in state.shots
        game.addShot @, shot

    @splitModel.onStateUpdate state.walkDirection, state.aimDirection, state.isMoving
    
  setNick: (@nicktext) ->
    @removeChild @nick if @nick
    @nick = new Text2D @nicktext
    @nick.position.y = -100
    @nick.position.z = 20
    @addChild @nick

  onFrame: (delta) ->
    @splitModel.onFrame delta

class Player extends PlayerUnit
  constructor: (state, @camera) ->
    super(state)
    @camera.target = this
    @state = state

  addState: (state) ->
    # Ignore server state for now. Validate client predictions later

  applyInput: (input, world) ->
    @state.applyInput input, world
    Player.__super__.addState.call this, @state
    @camera.position.x = @state.x
    @camera.position.y = @state.y - 800
    
    game.hud.onPlayerState @state

# export
@PlayerUnit = PlayerUnit
@Player = Player
