Feature: Fulfill Submission

  In order to preserve a monograph from the Toledo War Diaries
  As a Collection Manager
  I want to submit its scanned pages, OCR, and metadata for preservation.

 
  Scenario: Preserving the scanned pages, OCR, and metadata of a Toledo War Diaries monograph.
    Given a package containing the scanned pages, OCR, and metadata of a monograph
    When I submit the package for preservation 
    Then I can see that the scanned pages, OCR, and metadata was preserved as a monograph.

