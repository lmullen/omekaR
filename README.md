# omekaR

**An Omeka API client in R**

Please see the [documentation for the Omeka REST API](http://omeka.readthedocs.org/en/latest/Reference/api/), as well as information about [Omeka](http://omeka.org/) itself.

## Installation

First, make sure you have [devtools](https://github.com/hadley/devtools).

```
install.packages("devtools")
```

Then, install this package from the GitHub repository.

```
devtools::install_github("lmullen/omekaR")
```

## Basic use

First you must specify the API endpoint for the Omeka site that you are using. This will be stored in an environment variable. (To specify your API key, see `?omeka_key`.)

```
library(omekaR)
omeka_endpoint("http://20.rrchnm.org/api")
```

You can get resources using the following function. Here we grab the [site information](http://20.rrchnm.org/api/site?pretty_print), and a [single Omeka item](http://20.rrchnm.org/items/show/197).

```
site_info <- omeka_get("site")
war_dept <- omeka_get("items", 197)
```

The item is returned as a list. (If you get multiple items, then they are returned as a list of lists.) Some information about the item is easily accessed.

```
war_dept$id
war_dept$added
```

Most of the interesting information, however, is deeply nested within the list. You can use the following accessor function to get a named character vector of the item's metadata. Optionally you can pass a filter to get only certain kinds of metadata back.

```
element_texts(war_dept)
element_texts(war_dept, filter = "Content Experts")
element_texts(war_dept, filter = "Technology Used")
```

There is a function `get_all_items()` which will download all the items on an Omeka site, but use this with caution.
