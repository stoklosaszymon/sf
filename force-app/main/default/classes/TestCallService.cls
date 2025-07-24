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

    public static void createPostExample() {
        String url = 'https://jsonplaceholder.typicode.com/posts';

        Map<String, Object> postData = new Map<String, Object>{
            'title' => 'Test Title',
            'body' => 'This is the body of the post.',
            'userId' => 101
        };

        String body = JSON.serialize(postData);

        Map<String, String> headers = new Map<String, String>{
            'Content-Type' => 'application/json'
        };

        HttpResponse response = HttpService.sendRequest('POST', url, body, headers);

        if (response.getStatusCode() == 201) {
            System.debug('POST Success: ' + response.getBody());
        } else {
            System.debug('POST Error: ' + response.getStatusCode());
        }
    }
}
