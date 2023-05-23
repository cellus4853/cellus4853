# demo_http_server.py

from http.server import HTTPServer, BaseHTTPRequestHandler
# import cgi

class DemoServer(BaseHTTPRequestHandler):

    # Constructor
    def __init__(self, *args):
        #Constructor from base class
        BaseHTTPRequestHandler.__init__(self, *args)

    def do_GET(self):

        try :

            if self.path == "/":

                self.send_response(200) # success
                self.send_header('Content-type', 'text/html')
                self.end_headers()
                self.wfile.write(b"<html><head><title></title>Home</head>>")
                self.wfile.write(b"<body><h1>Welcome to my Page</h1></body>")
                self.wfile.write(b"</html>")

        except IOError:
            self.send_error(404, "File Not Found: %s" %self.path)

def run(server_class=HTTPServer, handler_class=DemoServer, port=9999):
    server_address =('localhost', port)
    httpd = server_class(server_address, handler_class)
    print('Starting httpd on port {}'.format(port))
    httpd.serve_forever()

run()
