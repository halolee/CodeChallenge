# Project Title

This is an attempt in response to Kogan's code challenge. It include a self contained Swift playground file which will 

* goes to the API end point
* parse Json into domain model
* calculate the average cubic weight for a selected category.

# Getting Started

The Swift playground will only works in a mac environment with internet connection


### Prerequisites

Please make sure the latest macOS and XCode is installed. At the time of development, the following environment is used:

* OS: macOS Sierra 10.12.4
* Tool: XCode 8.3.2
* Programming Language: Swift 3
* Internet connection that can reach api end point at `http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com`

### Installing

No installation is required. The playground file is self contained.

### Running

* Use XCode to open `KoganChallenge`.
* Wait for the network request to finish (normally takes 5 ~ 10 seconds)
* The expected result will be displayed in the `Debug area` at the bottom of XCode

If `Debug area` is not visible, please press `shift + command + C`

# Authors
* Hao Li

# License

This project is licensed under the MIT License

# Discussion

As this is time restricted code challenge, so the main focus is around how to get the average cubic weight.

Certain part has been taken out of the scope of response, such as pagination, error handling, and UX.

# Future work

Could be around improve the user experience in the UI perspective, such as

* load `objects` into a UITableView
* taking advantage of pagination
* provide interactive `category` selection
