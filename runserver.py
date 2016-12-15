import os
from bottle import run, request, response, route, template, static_file, default_app

import anxiety.controllers.api as json_api

@route('/')
def home() -> str:
    return template('anxiety/views/home')


################################################################################
# Static assets for web pages (stylesheets, javascript, etc)
################################################################################
@route('/static/<filepath:path>')
def server_static(filepath):
    """Serves static assets from the directory `equitas/static`.

    This supports returning static files from subdirectories within that
    directory. For example, it allows you to return css stylesheets or even
    javascript files from those directories. For example, in your HTML, you can
    have the following:

        <script src="/static/scripts/something/something_else.js"></script>

    And this would return the script within
    `equitas/static/scripts/something/something_else`.
    """
    this_directory = os.path.dirname(os.path.abspath(__file__))
    static_directory = os.path.join(this_directory, 'anxiety', 'static')

    return static_file(filepath, root=static_directory)


################################################################################
# API for JSON requests
################################################################################
@route('/api/countdowns', method='GET')
def get_countdowns() -> str:
    """Returns a json response of countdowns."""
    return json_api.get_countdowns(response)

@route('/api/countdowns', method='POST')
def insert_countdown():
    """Inserts a countdown into the database."""
    return json_api.insert_countdown(request)


# Run this only if we are not in production
if __name__ == '__main__':
    is_prod = os.getenv('PROD', False)

    if not is_prod:
        host = '0.0.0.0'
        port = '8080'

        run(host=host, port=port, debug=True)
    else:
        application = default_app()
