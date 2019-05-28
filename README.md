# Google AdWords
### Description
**DISCLAIMER**: Google AdWords is going to be deprecated sometimes at the beginning of 2020.
Please use Google Ads instead, the new API that uses GRPC and Protobuf.

This is an unfined project and required a bunch of more work.

It is a good example of how to work with SOAP and wsdl documents in the context of Elixir.

The integration uses SOAP to communicate with the Google AdWords.
It handles the creation of Budgets, Campaigns, AdGroups, ImageAssets and Multi-Asset Responsive Display Ads.
We can also get back reports such as: Impressions, Costs, Conversions and Clicks.

### Check the API
1. `git clone https://github.com/paperjuice/google_adwords_ex.git`
2. `cd google_adwords_ex`
3. `iex -S mix`
4. Browse to: http://localhost:9999/swagger/index.html#

### How to make successful requests
Right now the project doesn't support general user authorization.
We can make requests using our personal GoogleAdWords account.


The project requires a few environemnt variables.
```
export GOOGLE_CLIENT_ID=1111111111-kofsafdsafasfasdcxvzvzxtrewtre.apps.googleusercontent.com
export GOOGLE_SECRET=AaAaAaAAAAAaaaAaA
export CUSTOMER_ID=123-123-1234
export DEVELOPER_TOKEN=kfjwh3ifoqnjksnkvs
export SITE=https://accounts.google.com
export AUTHORIZE_URL=https://accounts.google.com/o/oauth2/auth
export REDIRECT_URI=http://localhost:9999/handle_code
export TOKEN_URL=https://www.googleapis.com/oauth2/v4/token
export USER_AGENT=ClientAdWordsOther
export SCOPE=https://www.googleapis.com/auth/adwords
```
TODO: explain how to get all the necessary information

### Generate the service files
We want to generate a `.hrl` and an `.erl` file for every service we include, in our case AssetService and AdGroupAdService. Those will be used for describing the location and the methods of the service.

1. Run `curl https://adwords.google.com/api/adwords/cm/v201806/AdGroupAdService?wsdl > ad_group.wsdl`.
   
2. Run `curl https://adwords.google.com/api/adwords/cm/v201806/AssetService?wsdl > asset.wsdl`.
(We write the result of curl to file)

The reason why we need both services is because AdGroupAd creates the multi-asset responsive ads while Asset creates an image asset. Image asset creation returns an ID that is required by multi-asset response ad.

3. We update AdWords.Utils.GenerateHrl attributes to match our requirement(the default is for AssetService)

4. We run `iex -S mix` and call `AdWords.Utils.GenerateHrl.wsdl_to_erlang`. This will generate an `.erl` and `.hrl` file.

5. Add the `.erl` file under `/src` and `.hrl` under `/include`


### Extracting records
In order to be able to properly generate the request's body you need to extract the Erlang records based on the necessary data structure. (TODO: Add short explanation how this works)

### Generate access token
##### Description
For authorisation and authentication, Google API uses OAuth2.0. 

| Headers          | Description                                                      | How to obtain
|:-----------------|:-----------------------------------------------------------------|:-------------------------------------|
| Authorization    | Passed under http request header like so: ```Authorization : Bearer YOUR_ACCESS_TOKEN```. |You can generate an access token by following the instructions below ```How to generate access token```.  |
| developerToken   | *SOAP Header* - a string of 22 chars that uniqly identifies the AdWords API developer. Ex: ```ABcdeFGH93KL-NOPQ_STUv```| Click the Tools, billing, and settings icon and select AdWords API Center under SETUP. You'll only see the AdWords API Center link if you're signed in to a manager account. |
| userAgent        | *SOAP Header* - useful for tracking request, Google recommends to use projects name + version. Ex: ```example.com:ReportDownloader:V7.18```| Pass a string that can be easy to used for diagnosing problems.                   |
| clientCustomerId | Customer ID of the target AdWords account. Ex: ```123-456-7890``` | [Follow this link to create an account](https://goo.gl/BVJtJc). For creating a test account you have to ```click here``` rather than ```Save and continue```![alt text](https://i.imgur.com/7Zv8Dcy.png)

For more information on the above, please follow this link: [API Call Structure](https://developers.google.com/adwords/api/docs/guides/signup)

##### How to generate access token
In order to obtain an access token, one needs to provide OAuth with `client_id`, `client_secret`, `redirect_uri`, `site`, `authorize_url` and `token_url`.

All the above information is stored under `config.exs` and belong to a test account.

If you need to request a token for a different account, make the appropriate changes under `Mix.Confi/ad_words`.

`access token`s are used to make request to the Google API. Those expire in one hour from creation.
`refresh token` never expire and are used to refresh the access token.

1. Make sure the information under `config.exs/ad_words` are accurate and the account you want to use.
2. Run `AdWords.Utils.Authenticate.OAuthTokens.generate_token`. By running this function you will get redirected to your default browser where you will have to log-in and give access to the Google App. This strategy is client-to-server and requires a one-time user interaction in order to get a code which will be used next to generate the access token.
3. Copy the code from the browser.
4. You will be prompted in the console to ```Type the verification code:``` which you copied from the broweser.
5. The token are stored in a file managed by DETS(on-dist Erlang term storage). To retrieve either access or refresh token, call ```AdWords.Utils.Authenticate.ManageTokens.get_token/1``` with either :access_token|:refresh_token

##### How to refresh access token
The life-span of an access token is one hour.
You can refresh the access token by calling ```AdWords.Utils.Authenticate.OAuthTokens.refresh_token/0```

### TODO
All the stories that I plan on covering are under ```Issues```.

