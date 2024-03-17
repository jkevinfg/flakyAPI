## Photo Downloader Script Challenge
 
We have a simple paginated API that returns a list of houses along with some metadata. Your challenge is to write a script that meets the requirements.

Note: this is a flaky API! That means that it will likely fail with a non-200 response code. Your code must handle these errors correctly so that all photos are downloaded.

### API Endpoint
You can request the data using the following endpoint:

```
http://app-homevision-staging.herokuapp.com/api_project/houses
```

This route by itself will respond with a default list of houses (or a server error!). You can use the following URL parameters:

```
page: the page number you want to retrieve (default is 1)
per_page: the number of houses per page (default is 10)
```
### Requirements
Requests the first 10 pages of results from the API

Parses the JSON returned by the API

Downloads the photo for each house and saves it in a file with the name formatted as:

```
[id]-[address].[ext]
```
