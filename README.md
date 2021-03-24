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
Whenever changes are merged into `master` on GitHub, CircleCI will take the files in `./apis` and upload them to a public Google Cloud Storage bucket (specifically [bluecore-openapi-docs](https://console.cloud.google.com/storage/browser/bluecore-openapi-docs;tab=objects?forceOnBucketsSortingFiltering=false&project=triggeredmail&prefix=&forceOnObjectsSortingFiltering=false)).

The corresponding Wordpress page pulls the config YAML file from Google Cloud Storage.
E.g. from the Wordpress set up of the Bluecore Transactional API Docs
```
<!-- YAML config file -->
<redoc spec-url='https://storage.googleapis.com/download/storage/v1/b/bluecore-openapi-docs/o/config_files%2Ftransactional_api.yaml?alt=media' hide-download-button></redoc>

<!-- Redoc script -->
<script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
```

When any changes are merged, all of the files in `./apis` will be deployed to GCS, and those changes will be reflected the next time the browser is loaded.


## How Do I Add New API Doc Pages?
Follow the steps below to create new docs for another Bluecore API:

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
Merge to master and verify your new docs have been deployed by going to [Google Cloud Storage](https://console.cloud.google.com/storage/browser/bluecore-openapi-docs;tab=objects?forceOnBucketsSortingFiltering=false&project=triggeredmail&prefix=&forceOnObjectsSortingFiltering=false) and looking for your files.

Finally, go to the live page on www.bluecore.com/your-api-here and check the live version of your docs!


## Next Steps
Short Term:
- Gather feedback from internal users
- Migrate the Bluecore Transactional API docs on KB to the new doc

Long Term:
- Identify other external APIs that need updated API docs
- Identify a better enterprise hosting solution for docs. The current solution of hosting our API docs on the marketing website is not ideal. There are limitations on Wordpress, such as URL structure for when we push up multiple pages, unconfigurable links in the nav bar and marketing bot widgets, etc.

