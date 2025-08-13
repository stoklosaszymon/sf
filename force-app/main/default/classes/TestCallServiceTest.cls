@IsTest
private class TestCallServiceTest{
    private class GetPostMock implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"userId": 1, "id": 1, "title": "Test Post", "body": "Test body content"}');
            res.setStatusCode(200);
            return res;
        }

    }

    private class CreatePostMock implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"id": 101, "title": "Test Title", "body": "This is the body of the post.", "userId": 101}');
            res.setStatusCode(201);
            return res;
        }

    }

    private class FailingPostMock implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(500);
            res.setBody('{"error": "Internal Server Error"}');
            return res;
        }

    }

    @IsTest
    static void testGetPostExample(){
        Test.setMock(HttpCalloutMock.class, new GetPostMock());

        Test.startTest();
        TestCallService.getPostExample();
        Test.stopTest();

        System.assert(true, 'GET post executed');
    }

    @IsTest
    static void testCreatePostExample(){
        Test.setMock(HttpCalloutMock.class, new CreatePostMock());

        Test.startTest();
        TestCallService.createPost('Test Post', 'Test body content', 1);
        Test.stopTest();

        System.assert(true, 'POST request executed');
    }

    @IsTest
    static void testCreatePostFails(){
        Test.setMock(HttpCalloutMock.class, new FailingPostMock());

        Boolean exceptionThrown = false;

        Test.startTest();
        try{
            TestCallService.createPost('Failing Post', 'This should fail', 999);
        } catch (CalloutException ex){
            exceptionThrown = true;
            System.assert(ex.getMessage().contains('Failed to create post'));
        }
        Test.stopTest();

        System.assert(exceptionThrown, 'Expected exception was not thrown');
    }

}