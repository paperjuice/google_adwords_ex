-module(asset_service_client).

-include("asset.hrl").

-export([interface/0]).

%% The functions that are described by the WSDL
-export([get/3]).
-export([mutate/3]).

-spec get(Soap_body::get(),
  Soap_headers::[soap:soap_header()],
  Options::[any()]) -> soap:soap_response(getResponse()).
get(Soap_body, Soap_headers, Options) ->
  soap_client_util:call(Soap_body, Soap_headers, Options, "\"\"", interface()).

-spec mutate(Soap_body::mutate(),
  Soap_headers::[soap:soap_header()],
  Options::[any()]) -> soap:soap_response(mutateResponse()).
mutate(Soap_body, Soap_headers, Options) ->
  soap_client_util:call(Soap_body, Soap_headers, Options, "\"\"", interface()).

%%% --------------------------------------------------------------------
%%% Internal functions
%%% --------------------------------------------------------------------
interface() ->
    ?INTERFACE.
