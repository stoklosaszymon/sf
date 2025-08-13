public class TestCallService {
    public static void getPostExample() {
        String url = 'https://jsonplaceholder.typicode.com/posts/1';
        HttpResponse response = HttpService.sendRequest('GET', url, null, null);

        if (response.getStatusCode() == 200) {
            System.debug('GET Success: ' + response.getBody());
        } else {
            System.debug('GET Error: ' + response.getStatusCode());
        }
    }

    public static Map<String, Object> createPost(String title, String body, Integer userId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        Map<String, Object> payload = new Map<String, Object>{
            'title' => title,
            'body' => body,
            'userId' => userId
        };

        req.setBody(JSON.serialize(payload));

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 201) {
            return (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        } else {
            throw new CalloutException('Failed to create post. Status: ' + res.getStatusCode());
        }
    }
}
