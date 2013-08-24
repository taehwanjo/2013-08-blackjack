class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    #if there are two hands, then if BOTH hands are greater than 21, then run bust function
    if @scores().length > 1
      console.log('score1: #{@scores()[0]} score2: #{@scores()[1]}')
      if @scores()[0] > 21 and @scores()[1] > 21 then @bust()
    else if @scores()[0] > 21 then @bust()


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]  #if there is a 2nd ace, only counts as 1

  stand: ->
    #@scores()[0] = the persons current scores
    @scores()[0]
    console.log('stand is being triggered from Hand.coffee')
    @trigger('stand', @)
    #@

  bust: ->
    console.log('busted!')
    @trigger('bust', @)
