Feature: Version Management

  Scenario Outline: Updating the version
    Given there is a version file at version 1.2.3
    And there is a history file
    When I increment the <version_type> version
    Then the project is tagged with <new_version>
    And the history file has been updated with <new_version>
    And the version file has been updated with <new_version>
    Examples: 
      | version_type | new_version |
      | major        | 2.0.0       | 
      | minor        | 1.3.0       |
      | patch        | 1.2.4       |
