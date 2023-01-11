Feature: Code Breaker Game
 
Guess the number in the game

    Scenario: Start a game
        Starting a game for guessing a number
        When I navigate to "localhost:4567"
        Then I should see page title as "CodeBreaker Game"
        Then element having id "input" should be present
        Then element having id "guess" should be present
 
    Scenario: Guess a number
        Given I enter "7519" into input field having id "input"
        When I click on element having id "guess"
        Then element having id "output" should have text as "____"
