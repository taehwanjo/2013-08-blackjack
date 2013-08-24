#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', @gameEnded, @)
    @get('playerHand').on('bust', @gameEnded, @)

  gameEnded: ->
    console.log('game ended')
    bestScore = (scoreArray) ->
      #define the bestScore method
      if scoreArray.length > 1
        if scoreArray[0] > 21 and scoreArray[1] > 21 then chosenScore = scoreArray[0]
        else if scoreArray[0] > 21 then chosenScore = scoreArray[1]
        else if scoreArray[1] > 21 then chosenScore = scoreArray[0]
        else
          if scoreArray[0] > scoreArray[1]
            chosenScore = scoreArray[0]
          else
            chosenScore = scoreArray[1]
      else
        chosenScore = scoreArray[0]
      return chosenScore

    #flip here
    console.log(@get('dealerHand').models[0].flip())
    console.log('DEALER SCORE: ' + @get('dealerHand').scores())
    dealerAI = (score) ->
      #while score < 17 then hit


    console.log "Game Ended.  Context: ", @
    #Calculates who won
    playerScore = bestScore(@get('playerHand').scores())
    dealerScore = bestScore(@get('dealerHand').scores())

    #if playerScore is greater than 21, then bust
    if playerScore > 21
      #You lose, increment dealer win count, show a pop up indicating the lost to the user
      @gameResult('loss')
    else
      dealerAI(dealerScore) #write dealer AI function
      if dealerScore > 21
        @gameResult('win')
      else
        if playerScore > dealerScore
          @gameResult('win')
        else if playerScore < dealerScore
          @gameResult('loss')
        else
          @gameResult('tie')

    #@get 'playerHand'.scores()[0]
    #all the score comparing and game restarting logic is here (deal another hand)
  restart: ->
    console.log('restarted')
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', @gameEnded, @)
    @get('playerHand').on('bust', @gameEnded, @)
    console.log('new player score: ' + @get('playerHand').scores()[0])
    @trigger('restart', @)

  gameResult: (result) ->
    if result is 'loss' then alert('You Lose!')
    if result is 'win' then alert('You Win!')
    if result is 'tie' then alert('You Tied.')
    @trigger('newButton', @)



###
if playerScoreArray.length > 1
      if playerScoreArray[0] > 21 and playerScoreArray[1] > 21 then playerScore = playerScoreArray[0]
      else if playerScoreArray[0] > 21 then playerScore = playerScoreArray[1]
      else if playerScoreArray[1] > 21 then playerScore = playerScoreArray[0]
      else
        if playerScoreArray[0] > playerScoreArray[1]
          playerScore = playerScoreArray[0]
        else
          playerScore = playerScoreArray[1]
    else
      playerScore = playerScoreArray[0]
###