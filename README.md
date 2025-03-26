# Bluecore OpenAPI Docs
This repository contains the files necessary to configure Bluecore API docs following Open API 3.0 specifications.

Currently, the only the [Bluecore Transactional API Docs](https://www.bluecore.com/transactional-api-docs/) are live.


## Config Files
OpenAPI Specification (formerly Swagger Specification) is an API description format for REST APIs. An OpenAPI file allows you to describe your entire API, including:

- Available endpoints (e.g. `/users`) and operations on each endpoint (`GET /users`, `POST /users`, etc.)
- Operation parameters Input and output for each operation
- Authentication methods
- Contact information, license, terms of use and other information.

API specifications are written in YAML. The format is easy to learn and readable to both humans and machines. The complete OpenAPI Specification can be found on GitHub: [OpenAPI 3.0 Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md)


## Redoc
The API specification YAML file is parsed by [Redoc](https://github.com/Redocly/redoc) - an open-source tool that generates the front-end components for our API docs.

To render API documentation using Redoc, all you need to do is add Redoc's  `<script>` tag on the page, along with a `<redoc>` tag pointing to the API specification YAML file.

e.g. HTML
```
  <body>
    <redoc spec-url='https://storage.googleapis.com/download/storage/v1/b/bluecore-openapi-docs/o/transactional-api%2Ftransactional_api.yaml?alt=media' hide-download-button></redoc>

    <script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
  </body>
```


## Hosting
Currently, docs are hosted on `www.bluecore.com/`, where our public-facing marketing pages live. API Docs are added as custom pages on Bluecore's Wordpress set up.

We chose to host the API Docs on Wordpress mainly because this was a solution that was free and quick to stand up. It is not a perfect solution and the recommendation would be to look for a better hosting solution for Bluecore's public API documentation.


## Deployment
Whenever changes are merged into `master` on GitHub, manually upload them to the public Google Cloud Storage bucket (specifically [bluecore-openapi-docs](https://console.cloud.google.com/storage/browser/bluecore-openapi-docs;tab=objects?forceOnBucketsSortingFiltering=false&project=triggeredmail&prefix=&forceOnObjectsSortingFiltering=false)). This had been handled by CircleCI when any changes are merged and all of the files in `./apis` were deployed to GCS. This is no longer the case and since we're going to be migrating away from this API (Q1 2025), it's not worth implementing an automated deployment.

The corresponding Wordpress page pulls the config YAML file from Google Cloud Storage.
E.g. from the Wordpress set up of the Bluecore Transactional API Docs
```
<!-- YAML config file -->
<redoc spec-url='https://storage.googleapis.com/download/storage/v1/b/bluecore-openapi-docs/o/config_files%2Ftransactional_api.yaml?alt=media' hide-download-button></redoc>

<!-- Redoc script -->
<script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
```


## How Do I Add New API Doc Pages?
You don't. We're not actively adding anything new here. Just updating the existing docs as needed for the Transactional API. New APIs should follow the new standard being established in Q1 2025.

The following steps below to create new docs for another Bluecore API are here for historical purposes (again do not add new APIs here):

#### Make a Config File
Make a new directory in `./apis/` with the name of the API (e.g. `mobile-events-api-v1`).
In that folder, create a YAML config file following Open API 3.0 specifications.
You can also add a CSS file for custom styling for this page.

To view locally, edit the `<redoc>` tag in `./index.html` to reference your new config file:
```
<redoc spec-url='./apis/mobile-events-api-v1/config.yaml' hide-download-button></redoc>
```

Then run `yarn open-redoc` from the command line. This will open up a live server on localhost using the contents of `index.html`. Any saved changes will cause the page to re-load with the new content.


#### Set Up the Wordpress Page
In Wordpress, add a new page on using the "API Docs" Wordpress template. You can set the page's URL to `your-api-name`.
You will need admin access on Wordpress to complete this step (contact the Marketing team if you need access).

The page contents should include the `<script>` tag to load Redoc on the page along with the `<redoc>` tag that references your API's YAML config file. You can also include a `<link>` tag to load custom CSS.

```
<!-- CSS -->
<link type="text/css" rel="stylesheet" href="https://storage.googleapis.com/download/storage/v1/b/bluecore-openapi-docs/o/css_files%2Ftransactional_api.css?alt=media">

<!-- YAML config file -->
<redoc spec-url='https://storage.googleapis.com/download/storage/v1/b/bluecore-openapi-docs/o/config_files%2Ftransactional_api.yaml?alt=media' hide-download-button></redoc>

<!-- Redoc script -->
<script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
```

The `href` and `spec-url`s follow Google Cloud Storage's URL format for [downloading Cloud Storage objects](https://cloud.google.com/storage/docs/downloading-objects).


#### Deploy to GCS
Merge to master, upload to [Google Cloud Storage](https://console.cloud.google.com/storage/browser/bluecore-openapi-docs;tab=objects?forceOnBucketsSortingFiltering=false&project=triggeredmail&prefix=&forceOnObjectsSortingFiltering=false) 
then go validate the [live version of your docs](https://www.bluecore.com/apis/transactional-api/)!


