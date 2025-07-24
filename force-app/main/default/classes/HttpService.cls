public class HttpService {
    
    private static final String DEFAULT_CONTENT_TYPE = 'application/json';

    public static HttpResponse sendRequest(String method, String endpointUrl, String body, Map<String, String> headers) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(endpointUrl);
        request.setMethod(method);
        
        if (headers != null) {
            for (String key : headers.keySet()) {
                request.setHeader(key, headers.get(key));
            }
        }

        if (headers == null || !headers.containsKey('Content-Type')) {
            request.setHeader('Content-Type', DEFAULT_CONTENT_TYPE);
        }

        if (body != null && (method == 'POST' || method == 'PUT' || method == 'PATCH')) {
            request.setBody(body);
        }

        try {
            HttpResponse response = http.send(request);
            return response;
        } catch (System.CalloutException e) {
            System.debug('HTTP Callout Error: ' + e.getMessage());
            throw e;
        }
    }
}