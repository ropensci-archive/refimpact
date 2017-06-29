# refimpact 1.0.0

* Major breaking changes. There is now a single user-facing function `ref_get()`
  which takes the API method as an argument. This standardises a lot of the 
  input validation and error handling, as well as reducing the risk of bugs (as 
  there are less lines of code). Functions from previous version of the package
  are still available, but deprecated.
* A vignette has been added, and the help documentation has been improved.
* The package now uses **httr** when calling the API, which improves reliability
  and provides much better error messages to the end-user when things go wrong.
* The `phrase` parameter to the SearchCaseStudies method now allows text queries
  of any length and complexity
* Bundled a `ref_tags` dataset with the package, to save the end-user from 
  having to iterate through the ListTagValues API method in order to find tags
  to use as parameters when searching the database
* Added a contributor code of conduct
* The entire package was re-written.

# refimpact 0.1.0

* Initial release.
