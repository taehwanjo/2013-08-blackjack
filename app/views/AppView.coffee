class window.AppView extends Backbone.View

  template: _.template '
    <div class="top-buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": ->
      @model.get('playerHand').stand()
    "click .new-hand": -> @model.restart()

  initialize: ->
    @render()
    #@model.on('gameResult', @render)
    @model.on('newButton', @newButton) # does not work but executes at beginning
    @model.on('restart', @render)
    #@model.on('stand', console.log('test2')) # does not work but executes at beginning
  newButton: ->
    console.log("NEW BUTTON ADD")
    @$el.find('.top-buttons').html '<button class="new-hand">New Hand</button>'

  render: ->
    console.log('rendered')
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

#So we need to calculate the scores and match them but in order to do that we have to do the following:
  #Flip the dealers card over and calculate it