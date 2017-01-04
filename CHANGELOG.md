# Change Log
All notable changes to this project will be documented in this file.

## [0.2.0] - 2017-01-04
### Added
- Support for the International Street Address API

### Changed
- Fix the comparison of the response HTTP code to pass the proper error message to the SevereApiError.

## [0.1.2] - 2017-01-02
### Changed
- Fix the comparison of the response HTTP code to pass the proper error message to the SevereApiError.

## [0.1.1] - 2016-12-21
### Changed
- Raise a `SevereApiError` when an API exception happens
- Fix the error handling sequence so that error responses are not JSON parsed.
- Drop the support for Ruby 1.9

## [0.1.0] - 2016-06-20
### Added
- US Street Address API
