Feature: Code Breaker Game
 
Guess the number in the game

    Scenario: Start a game
        Starting a game for guessing a number
        When I navigate to "localhost:4567"
        Then I should see page title as "CodeBreaker Game"
        Then element having id "input" should be present
        Then element having id "guess" should be present
 
    Scenario: Guess a wrong number
        Given I enter "7510" into input field having id "input"
        When I click on element having id "guess"
        Then element having id "output" should have text as "___"
        And element having id "message" should have text as "Try again!"

    Scenario: Guess the right number
        Given I enter "7519" into input field having id "input"
        When I click on element having id "guess"
        Then element having id "output" should have text as "____"
        And element having id "message" should have text as "You win!"


    Scenario: List of numbers guessed
        Given I enter "1094" into input field having id "input"
        When I click on element having id "guess"
        Then element having id "output" should have text as "XX"
        When I enter "0123" into input field having id "input"
        And I click on element having id "guess"
        Then element having id "output" should have text as "X"
        And element having id "results" should have text as "1094 - XX"
        And element having id "results" should have text as "0123 - X"