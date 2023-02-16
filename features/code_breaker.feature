Feature: Code Breaker Game
  Guess the number in the game

  Background: Start a game
    Starting a game for guessing a number
    When I navigate to "localhost:4567"
    Then I should see page title as "Type your name"
    Then I enter "Hector" into input field having id "name"
    When I click on element having id "name_register"
    Then I should see page title as "CodeBreaker Game"
    Then element having id "input" should be present
    Then element having id "guess" should be present

  Scenario: Guess a repeated number
    Given I enter "7510" into input field having id "input"
    When I click on element having id "guess"
    Then I enter "7510" into input field having id "input"
    When I click on element having id "guess"
    Then element having id "repeated_number" should be present
    And element having id "repeated_number" should have text as "You already tried 7510, try something else"


  Scenario: Guess a wrong number
    Given I enter "7510" into input field having id "input"
    When I click on element having id "guess"
    Then element having id "output" should have text as "___"
    And element having id "message" should have text as "Try again!"

  Scenario: Guess the right number on the first try
    Given I enter "7519" into input field having id "input"
    When I click on element having id "guess"
    Then element having id "output" should have text as "____"
    And element having id "message" should have text as "You win! and your score is 10"


  Scenario: List of numbers guessed
    Given I enter "1094" into input field having id "input"
    When I click on element having id "guess"
    Then element having id "output" should have text as "XX"
    When I enter "0123" into input field having id "input"
    And I click on element having id "guess"
    Then element having id "output" should have text as "X"
    And element having id "results" should have partial text as "1094 - XX"
    And element having id "results" should have partial text as "0123 - X"

  Scenario: Ran out of attempts
    Given I enter "1080" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1081" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1082" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1083" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1084" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1085" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1086" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1087" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1088" into input field having id "input"
    When I click on element having id "guess"
    Given I enter "1089" into input field having id "input"
    When I click on element having id "guess"
    And element having id "message" should have text as "Game Over!"
    Then element having id "try_again" should be present
